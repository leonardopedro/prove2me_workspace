-- Generated from ChapterCoherentPositionSpace.lean — theorem BookProof.ChapterCoherentPositionSpace.packetBorn_eq_scoreSoftmax
import Definitions.Def_ChapterCoherentOverlap
import Mathlib
import Definitions.Def_ChapterCoherentPositionSpace
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterCoherentPositionSpace


open scoped BigOperators
open MeasureTheory

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxSharpness

theorem BookProof.ChapterCoherentPositionSpace.packetBorn_eq_scoreSoftmax {m : ℕ} (q : ℝ) (k : Fin m → ℝ) (j : Fin m) :
    packetBorn q k j = scoreSoftmax (1 / 2) (fun l => -(q - k l) ^ 2) j := by sorry
