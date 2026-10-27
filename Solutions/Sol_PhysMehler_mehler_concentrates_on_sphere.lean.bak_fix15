-- Generated from PhysMehler.lean — solution of PhysMehler.mehler_concentrates_on_sphere
import Mathlib
import Definitions.Def_PhysMehler
open PhysMehler



open MeasureTheory Set Filter TopologicalSpace
open scoped ENNReal Topology BigOperators

noncomputable section


open PhysMeasureBasis PhysFunctionalAnalysis PhysHSGaussian

set_option maxHeartbeats 1000000 in
theorem solution :
    ∀ᵐ ω ∂MehlerPrior, Tendsto (fun k => normSq k ω / k) atTop (𝓝 1) := gaussian_concentration_sphere
