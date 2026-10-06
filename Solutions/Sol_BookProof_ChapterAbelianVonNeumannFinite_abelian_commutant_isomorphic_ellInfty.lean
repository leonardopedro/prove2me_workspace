-- Generated from ChapterAbelianVonNeumannFinite.lean — solution of BookProof.ChapterAbelianVonNeumannFinite.abelian_commutant_isomorphic_ellInfty
import Mathlib
import Definitions.Def_ChapterAbelianVonNeumannFinite
import Theorems.Thm_BookProof_ChapterAbelianVonNeumannFinite_conjDiagonal_injective
import Theorems.Thm_BookProof_ChapterAbelianVonNeumannFinite_commutant_eq_range_conjDiagonal
open BookProof.ChapterAbelianVonNeumannFinite



open Matrix


variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution {A : Matrix n n ℂ} (hA : A.IsHermitian)
    (hdist : Function.Injective hA.eigenvalues) :
    ∃ f : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ,
      Function.Injective f ∧ Set.range f = {M : Matrix n n ℂ | M * A = A * M} :=
  ⟨conjDiagonal hA.eigenvectorUnitary, conjDiagonal_injective _,
      (commutant_eq_range_conjDiagonal hA hdist).symm⟩
