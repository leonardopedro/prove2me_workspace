-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.inclPow_purePow
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution : ∀ (n : ℕ) (f : Fin n → D₂),
    inclPow Hs D₂ n (purePow (domSpace Hs D₂) n f)
      = purePow Hs n (fun i => ((f i : Hs.carrier))) := by

  intro n
  induction n with
  | zero => intro f; rfl
  | succ n ih =>
      intro f
      rw [purePow_succ, inclPow_tmul, ih, purePow_succ]
      rfl
