-- Generated from ChapterCoreBoundsEsa.lean — solution of BookProof.CoreBounds.essentiallySelfAdjointOn_finiteModes_of_core_bounds_comm
import Mathlib
import Definitions.Def_ChapterCoreBoundsEsa
import Theorems.Thm_BookProof_CoreBounds_essentiallySelfAdjointOn_finiteModes_of_core_bounds
open BookProof.CoreBounds




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.OperatorSeries
open Filter Topology

noncomputable section

variable {ι : Type*} {c : ι → ℝ}

variable {ι : Type*} {c : ι → ℝ}
variable (H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι) (A : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution
    (c : ι → ℝ) (hc : ∀ k, 0 ≤ c k) (H₀ : lpFiniteModes ι →ₗ[ℂ] L2I ι) (A : ℝ)
    (hsym : ∀ u v : lpFiniteModes ι,
      (inner ℂ (H₀ u) ((v : L2I ι)) : ℂ) = inner ℂ ((u : L2I ι)) (H₀ v))
    (hA : CoreRelBound c H₀ A)
    (hcomm : ∀ u : lpFiniteModes ι,
      (inner ℂ (H₀ u) ((diagMax c (inclC c u) : L2I ι)) : ℂ).im = 0) :
    EssentiallySelfAdjointOn (lpFiniteModes ι) H₀ := by

  refine essentiallySelfAdjointOn_finiteModes_of_core_bounds c hc H₀ A 0 le_rfl hsym hA ?_
  intro u
  rw [hcomm u]
  simp
