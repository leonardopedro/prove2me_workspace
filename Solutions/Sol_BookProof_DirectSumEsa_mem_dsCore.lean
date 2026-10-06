-- Generated from ChapterDirectSumEsa.lean — solution of BookProof.DirectSumEsa.mem_dsCore
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
open BookProof.DirectSumEsa



open scoped ENNReal


open BookProof.FarisLavine

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]

set_option maxHeartbeats 1000000 in
theorem solution {D : ∀ i, Submodule ℂ (G i)} {f : lp G 2} :
    f ∈ dsCore D ↔ {i | (f : ∀ i, G i) i ≠ 0}.Finite ∧ ∀ i, (f : ∀ i, G i) i ∈ D i := Iff.rfl
