-- Generated from ChapterCarlemanUnboundedHop.lean — solution of BookProof.CarlemanUnboundedHop.kernelOp_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Theorems.Thm_BookProof_CarlemanUnboundedHop_kernelOp_deficiencyTrivialAt
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow
open BookProof.FarisLavine
open BookProof.CarlemanUnboundedHop




open Finset

noncomputable section

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {a : ℕ → ℕ → ℂ} {A θ Θ : ℕ → ℝ} (hk : IsL2Kernel a)
    (hθ0 : ∀ r, 0 ≤ θ r) (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j))
    (hΘsum : Summable Θ) (hApos : ∀ n, 0 < A n) (hAmono : Monotone A)
    (hbd : ∀ n k, n < k → ‖a n k‖ ≤ A n * θ (k - n))
    (hcar : ¬ Summable fun n => (A n)⁻¹) :
    EssentiallySelfAdjointOn (lpFiniteModes ℕ) (kernelOp hk) :=
  ⟨kernelOp_deficiencyTrivialAt hk hθ0 hΘ hΘsum hApos hAmono hbd hcar (by simp),
      kernelOp_deficiencyTrivialAt hk hθ0 hΘ hΘsum hApos hAmono hbd hcar (by simp)⟩
