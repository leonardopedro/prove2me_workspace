import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound

open BookProof.ChapterHermiteRelativeBound




open Matrix
open scoped ComplexConjugate


variable {(i : Fin d) : SymmetricOn (polyGaussCore (d := d)) (posL i)}


theorem posL_symmetric := by sorry
