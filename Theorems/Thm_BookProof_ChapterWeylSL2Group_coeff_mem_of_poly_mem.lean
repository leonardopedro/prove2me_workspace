-- Generated from ChapterWeylSL2Group.lean — theorem BookProof.ChapterWeylSL2Group.coeff_mem_of_poly_mem
import Definitions.Def_ChapterWeylSl2
import Mathlib
import Definitions.Def_ChapterWeylSL2Group
open BookProof.ChapterWeylSL2Group

variable {V : Type u} [AddCommGroup V] [Module ℂ V]



open BookProof.ChapterWeylSl2

universe u


theorem BookProof.ChapterWeylSL2Group.coeff_mem_of_poly_mem {W : Submodule ℂ V} {N : ℕ} {c : ℕ → V}
    (h : ∀ t : ℂ, ∑ k ∈ Finset.range N, t ^ k • c k ∈ W) {k : ℕ} (hk : k < N) : c k ∈ W := by sorry
