-- Generated from ChapterSolovaySeparableExistence.lean — solution of BookProof.ChapterSolovaySeparableExistence.innerSpace_separable
import Mathlib
import Definitions.Def_ChapterSolovaySeparableExistence
import Definitions.Def_ChapterSolovayCoordinates
import Definitions.Def_PhysMeasureBasis
open BookProof.ChapterSolovaySeparableExistence



noncomputable section

open MeasureTheory ProbabilityTheory


open BookProof.ChapterSolovayCoordinates
open PhysMeasureBasis

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ) :
    TopologicalSpace.SeparableSpace (_root_.InnerSpace N) := by

  haveI := PhysMehler.substrate_separable
  infer_instance
