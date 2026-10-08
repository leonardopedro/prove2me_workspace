-- Generated from ChapterAbelianVonNeumannFinite.lean — theorem BookProof.ChapterAbelianVonNeumannFinite.abelian_commutant_isomorphic_ellInfty
import Mathlib
import Definitions.Def_ChapterAbelianVonNeumannFinite
open BookProof.ChapterAbelianVonNeumannFinite


open Matrix


variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.ChapterAbelianVonNeumannFinite.abelian_commutant_isomorphic_ellInfty {A : Matrix n n ℂ} (hA : A.IsHermitian)
    (hdist : Function.Injective hA.eigenvalues) :
    ∃ f : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ,
      Function.Injective f ∧ Set.range f = {M : Matrix n n ℂ | M * A = A * M} := by sorry
