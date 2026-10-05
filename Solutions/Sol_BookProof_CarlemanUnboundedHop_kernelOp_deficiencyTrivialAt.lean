-- Generated from ChapterCarlemanUnboundedHop.lean — solution of BookProof.CarlemanUnboundedHop.kernelOp_deficiencyTrivialAt
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Theorems.Thm_BookProof_CarlemanUnboundedHop_ladder_eq_zero_of_carleman
import Theorems.Thm_BookProof_CarlemanUnboundedHop_summable_normSq_lp
import Theorems.Thm_BookProof_CarlemanUnboundedHop_ladderRec_of_deficiency
open BookProof.CarlemanUnboundedHop




open Finset

noncomputable section

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {a : ℕ → ℕ → ℂ} {A θ Θ : ℕ → ℝ} (hk : IsL2Kernel a)
    (hθ0 : ∀ r, 0 ≤ θ r) (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j))
    (hΘsum : Summable Θ) (hApos : ∀ n, 0 < A n) (hAmono : Monotone A)
    (hbd : ∀ n k, n < k → ‖a n k‖ ≤ A n * θ (k - n))
    (hcar : ¬ Summable fun n => (A n)⁻¹) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (lpFiniteModes ℕ) (kernelOp hk) z := by

  intro w hw
  have hrec := ladderRec_of_deficiency hk hw
  have hzero := ladder_eq_zero_of_carleman hz hk.herm hrec (summable_normSq_lp w)
    hθ0 hΘ hΘsum hApos hAmono hbd hcar
  exact lp.ext (funext hzero)
