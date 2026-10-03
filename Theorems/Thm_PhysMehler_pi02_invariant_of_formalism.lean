-- Generated from PhysMehler.lean — theorem PhysMehler.pi02_invariant_of_formalism
import Mathlib
import Definitions.Def_PhysMehler
import Definitions.Def_ChapterA4
open PhysMehler


open MeasureTheory Set Filter TopologicalSpace
open scoped ENNReal Topology BigOperators

noncomputable section


open PhysMeasureBasis PhysFunctionalAnalysis PhysHSGaussian

theorem PhysMehler.pi02_invariant_of_formalism {H : Type*} [NormedAddCommGroup H]
    [InnerProductSpace ℝ H] [CompleteSpace H] [MeasurableSpace H]
    (p : ℕ → ℕ → Bool) (F₁ F₂ : Formalism H) (z : ZFSet) :
    interpPi02 p F₁ z ↔ interpPi02 p F₂ z := by sorry
