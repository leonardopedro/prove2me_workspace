-- Generated from PhysMehler.lean — theorem PhysMehler.interpPi02_eq
import Mathlib
import Definitions.Def_PhysMehler
import Definitions.Def_ChapterA4
open PhysMehler


open MeasureTheory Set Filter TopologicalSpace
open scoped ENNReal Topology BigOperators

noncomputable section


open PhysMeasureBasis PhysFunctionalAnalysis PhysHSGaussian

theorem PhysMehler.interpPi02_eq {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℝ H]
    [CompleteSpace H] [MeasurableSpace H]
    (p : ℕ → ℕ → Bool) (F : Formalism H) (z : ZFSet) :
    interpPi02 p F z ↔ Pi02 p := by sorry
