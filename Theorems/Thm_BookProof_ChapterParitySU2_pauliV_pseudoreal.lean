-- Generated from ChapterParitySU2.lean — theorem BookProof.ChapterParitySU2.pauliV_pseudoreal
import Mathlib
import Definitions.Def_ChapterParitySU2
import Definitions.Def_ChapterParity
open BookProof.ChapterParity
open BookProof.ChapterParitySU2


open Matrix
open scoped ComplexConjugate


open BookProof.ChapterParity

theorem BookProof.ChapterParitySU2.pauliV_pseudoreal (j : Fin 3) :
    pauli2 * pauliV j * pauli2 = -((pauliV j).map (starRingEnd ℂ)) := by sorry
