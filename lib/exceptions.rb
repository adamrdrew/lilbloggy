class DuplicateUserException < StandardError
end
class WrongPasswordException < StandardError
end
class UserNotFoundException < StandardError
end
class SignupDisabledException < StandardError
end