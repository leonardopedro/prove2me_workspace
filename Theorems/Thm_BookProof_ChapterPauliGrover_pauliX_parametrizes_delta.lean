-- Generated from ChapterPauliGrover.lean — theorem BookProof.ChapterPauliGrover.pauliX_parametrizes_delta
import Definitions.Def_ChapterConditional
import Mathlib
import Definitions.Def_ChapterPauliGrover
open BookProof.ChapterPauliGrover


open scoped BigOperators Matrix ComplexConjugate
open Matrix
open BookProof.ChapterConditional

theorem BookProof.ChapterPauliGrover.pauliX_parametrizes_delta (y : Fin 2) :
    ‖pauliX y 0‖ ^ 2 = (if y = 1 then 1 else 0 : ℝ) := by sorry
