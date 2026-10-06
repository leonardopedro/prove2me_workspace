-- Generated from ChapterGravityIrrep.lean — theorem BookProof.ChapterGravityIrrep.frob_symTraceless_trace
import Mathlib
import Definitions.Def_ChapterGravityIrrep
open BookProof.ChapterGravityIrrep



open Matrix
open scoped BigOperators

theorem BookProof.ChapterGravityIrrep.frob_symTraceless_trace (M : Matrix (Fin 3) (Fin 3) ℝ) :
    frobInner (symTracelessPart M) ((M.trace) • (1 : Matrix (Fin 3) (Fin 3) ℝ)) = 0 := by sorry
