-- Generated from PhysMehler.lean — theorem PhysMehler.model_has_prior
import Mathlib
import Definitions.Def_PhysMehler
import Definitions.Def_ChapterA4
open PhysMehler


open MeasureTheory Set Filter TopologicalSpace
open scoped ENNReal Topology BigOperators

noncomputable section


open PhysMeasureBasis PhysFunctionalAnalysis PhysHSGaussian

theorem PhysMehler.model_has_prior {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℝ H]
    [CompleteSpace H] [MeasurableSpace H] (F : Formalism H) :
    IsProbabilityMeasure F.prior ∧ ∀ x, F.prior {x} = 0 := by sorry
