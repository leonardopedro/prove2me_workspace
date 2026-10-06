-- Generated from ChapterParitySU2.lean — theorem BookProof.ChapterParitySU2.su2_conj_inner
import Mathlib
import Definitions.Def_ChapterParitySU2
import Definitions.Def_ChapterParity
open BookProof.ChapterParity
open BookProof.ChapterParitySU2


open Matrix
open scoped ComplexConjugate


open BookProof.ChapterParity

theorem BookProof.ChapterParitySU2.su2_conj_inner (j : Fin 3) :
    (su2gen j).map (starRingEnd ℂ) = pauli2 * su2gen j * pauli2 := by sorry
