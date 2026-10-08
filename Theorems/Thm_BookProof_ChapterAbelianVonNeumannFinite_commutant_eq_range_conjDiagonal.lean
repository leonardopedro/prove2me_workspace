-- Generated from ChapterAbelianVonNeumannFinite.lean — theorem BookProof.ChapterAbelianVonNeumannFinite.commutant_eq_range_conjDiagonal
import Mathlib
import Definitions.Def_ChapterAbelianVonNeumannFinite
open BookProof.ChapterAbelianVonNeumannFinite


open Matrix


variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.ChapterAbelianVonNeumannFinite.commutant_eq_range_conjDiagonal {A : Matrix n n ℂ} (hA : A.IsHermitian)
    (hdist : Function.Injective hA.eigenvalues) :
    {M : Matrix n n ℂ | M * A = A * M} = Set.range (conjDiagonal hA.eigenvectorUnitary) := by sorry
