-- Generated from ChapterGravityIrrep.lean — theorem BookProof.ChapterGravityIrrep.frob_symTraceless_antisym
import Mathlib
import Definitions.Def_ChapterGravityIrrep
open BookProof.ChapterGravityIrrep



open Matrix
open scoped BigOperators

theorem BookProof.ChapterGravityIrrep.frob_symTraceless_antisym (M : Matrix (Fin 3) (Fin 3) ℝ) :
    frobInner (symTracelessPart M) (antisymPart M) = 0 := by sorry
