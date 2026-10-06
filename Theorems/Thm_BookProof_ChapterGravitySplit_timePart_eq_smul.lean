-- Generated from ChapterGravitySplit.lean — theorem BookProof.ChapterGravitySplit.timePart_eq_smul
import Mathlib
import Definitions.Def_ChapterGravitySplit
import Definitions.Def_ChapterGravityProjector
import Definitions.Def_ChapterGravityTimeProj
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj
open BookProof.ChapterGravitySplit



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

theorem BookProof.ChapterGravitySplit.timePart_eq_smul (v x : Fin 4 → ℝ) :
    timePart v x = (-(minkForm x v)) • v := by sorry
