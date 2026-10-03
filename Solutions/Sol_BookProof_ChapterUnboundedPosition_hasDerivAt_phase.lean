-- Generated from ChapterUnboundedPosition.lean — solution of BookProof.ChapterUnboundedPosition.hasDerivAt_phase
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnboundedPosition



open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

set_option maxHeartbeats 1000000 in
theorem solution (f : ℤ → ℝ) (k : ℤ) :
    HasDerivAt (fun t : ℝ => phase f t k) (Complex.I * f k) 0 :=
  phase (f : ℤ → ℝ) (k : ℤ) :
      HasDerivAt (fun t : ℝ => phase f t k) (Complex.I * f k) 0 := by
    have h1 : HasDerivAt (fun t : ℝ => Complex.I * ((t * f k : ℝ) : ℂ)) (Complex.I * f k) 0 := by
      have h0 : HasDerivAt (fun t : ℝ => ((t * f k : ℝ) : ℂ)) ((f k : ℂ)) 0 := by
        simpa using ((hasDerivAt_id (0 : ℝ)).mul_cons
