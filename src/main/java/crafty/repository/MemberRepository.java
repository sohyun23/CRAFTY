package crafty.repository;

import crafty.dto.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.transaction.Transactional;
import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long> {

	// find Account
	Optional<Member> findByLoginIdAndPhoneNum(String loginId, String phoneNum);
	
    @Modifying
    @Transactional
    @Query("UPDATE Member m SET m.loginPw = :password WHERE m.loginId = :loginId AND m.phoneNum = :phoneNum")
    void updatePassword(@Param("loginId") String loginId, @Param("phoneNum") String phoneNum, @Param("password") String password);

}