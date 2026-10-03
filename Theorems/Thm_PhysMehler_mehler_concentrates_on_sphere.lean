-- Generated from PhysMehler.lean — theorem PhysMehler.mehler_concentrates_on_sphere
import Mathlib
import Definitions.Def_PhysMehler
import Definitions.Def_ChapterA4
open PhysMehler


open MeasureTheory Set Filter TopologicalSpace
open scoped ENNReal Topology BigOperators

noncomputable section


open PhysMeasureBasis PhysFunctionalAnalysis PhysHSGaussian

theorem PhysMehler.mehler_concentrates_on_sphere :
    ∀ᵐ ω ∂MehlerPrior, Tendsto (fun k => normSq k ω / k) atTop (𝓝 1) := by sorry
