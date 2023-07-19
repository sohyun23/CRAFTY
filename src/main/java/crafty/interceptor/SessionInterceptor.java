package crafty.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import lombok.extern.slf4j.Slf4j;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Slf4j
public class SessionInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(HttpServletRequest request, 
                            HttpServletResponse response, 
                            Object handler) throws Exception {
        
        log.info("preHandle");
        
        // session 가져오기
        HttpSession session = request.getSession(false);
        
        if(session == null || session.getAttribute("loginId") == null) {
            // 로그인 세션이 없을 경우 로그인 페이지로 리다이렉트        
            response.sendRedirect("/login");
            // false : controller로 더이상 요청 진행 x
            return false;
        }
        
        // 로그인 세션이 있을 경우 세션에 로그인 id, memberId, position, profileImg 정보 부여
        String loginId = (String) session.getAttribute("loginId");
        Long memberId = (Long) session.getAttribute("memberId");
        Integer position = (Integer) session.getAttribute("position");
        String profileImg = (String) session.getAttribute("profileImg");
        
        request.setAttribute("loginId", loginId);
        request.setAttribute("memberId", memberId);
        request.setAttribute("position", position);
        request.setAttribute("profileImg", profileImg);
        
        // 요청 진행
        return true;
    }
    
}