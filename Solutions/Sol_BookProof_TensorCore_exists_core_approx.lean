-- Generated from ChapterTensorGraphCore.lean — solution of BookProof.TensorCore.exists_core_approx
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
import Theorems.Thm_BookProof_TensorCore_graphPow_range_le_closure
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
open BookProof.TensorCore




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore
open BookProof.GraphCore

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in

theorem solution (hcore : IsGraphCore D A) (n : ℕ)
    (x : ((domSpace Hs D₂).pow n)) {ε : ℝ} (hε : 0 < ε) :
    ∃ y ∈ corePow Hs D₂ D n,
      ‖inclPow Hs D₂ n x - inclPow Hs D₂ n y‖ < ε ∧
        ‖derPow Hs D₂ A n x - derPow Hs D₂ A n y‖ < ε := by
  have hmem : graphPow Hs D₂ A n x ∈
      (Submodule.map (graphPow Hs D₂ A n) (corePow Hs D₂ D n)).topologicalClosure :=
    graphPow_range_le_closure Hs D₂ A D hcore n ⟨x, rfl⟩
  have hmem' : graphPow Hs D₂ A n x ∈
      closure ((Submodule.map (graphPow Hs D₂ A n) (corePow Hs D₂ D n)) : Set _) := hmem
  obtain ⟨z, hz, hdist⟩ := Metric.mem_closure_iff.mp hmem' ε hε
  obtain ⟨y, hy, rfl⟩ := hz
  -- Current Mathlib's simp normalises `max _ _ < ε` into a conjunction immediately, so we
  -- state the componentwise bound directly instead of going through `max_lt_iff.mp`.
  have hconj : ‖inclPow Hs D₂ n x - inclPow Hs D₂ n y‖ < ε ∧
      ‖derPow Hs D₂ A n x - derPow Hs D₂ A n y‖ < ε := by
    simpa [graphPow, LinearMap.prod_apply, Prod.dist_eq, dist_eq_norm] using hdist
  exact ⟨y, hy, hconj.1, hconj.2⟩

/-! ## The sector inside `H^{⊗n}` -/
