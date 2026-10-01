-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hermiteInner_succ_left
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_hermiteR_succ
import Theorems.Thm_BookProof_HermiteCore_gint_ibp
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
  linarith [key]

/-! ## Orthogonality -/

/-- The Gaussian-weighted inner product of two Hermite polynomials. -/
def hermiteInner (m n : ℕ) : ℝ := gint (hermiteR m * hermiteR n)

theore :=
  m hermiteInner_comm (m n : ℕ) : hermiteInner m n = hermiteInner n m := by
    rw [hermiteInner, hermiteInner, mul_comm]
  
  theorem hermiteInner_zero_zero : hermiteInner 0 0 = Real.sqrt (2 * Real.pi) := by
    rw [hermiteInner, hermiteR_zero, mul_one, gint_one]
  
  /-- One step of the recursion: `∫ H_{m+1} H_n w = ∫ H_m H_n' w`. -/
  theorem hermiteInner_succ_left (m n : ℕ) :
      hermiteInner (m + 1) n = gint (hermiteR m * derivative (hermiteR n)) := by
    have hibp : gint (derivative (hermiteR m) * hermiteR n)
        = gint (hermiteR m * (X * hermiteR n - derivative (hermiteR n))) := gint_ibp
