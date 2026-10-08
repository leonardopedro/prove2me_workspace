-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.purePow_mem_corePow
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_TensorCore_tmul_mem_corePow
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution : ∀ (n : ℕ) (f : Fin n → D₂),
    (∀ i, ((f i : Hs.carrier)) ∈ D) →
      purePow (domSpace Hs D₂) n f ∈ corePow Hs D₂ D n := by

  intro n
  induction n with
  | zero => intro f _; trivial
  | succ n ih =>
      intro f hf
      rw [purePow_succ]
      exact tmul_mem_corePow Hs D₂ D (hf 0) (ih (Fin.tail f) (fun i => hf i.succ))
