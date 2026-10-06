-- Generated from ChapterCoherentPositionSpace.lean — theorem BookProof.ChapterCoherentPositionSpace.gaussianPacket_inner_sq_eq_coherentOverlap
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterCoherentPositionSpace
import Definitions.Def_ChapterCoherentOverlap
import Definitions.Def_ChapterHermiteProductCore
open BookProof.ChapterCoherentOverlap
open BookProof.HermiteProductCore
open BookProof.ChapterCoherentPositionSpace


open scoped BigOperators
open MeasureTheory

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxSharpness

theorem BookProof.ChapterCoherentPositionSpace.gaussianPacket_inner_sq_eq_coherentOverlap (a b : ℝ) :
    (∫ x : ℝ, gaussianPacket a x * gaussianPacket b x) ^ 2
      = coherentOverlap (WithLp.toLp 2 (fun _ => a) : EuclideanSpace ℝ (Fin 1))
          (WithLp.toLp 2 (fun _ => b)) := by sorry
