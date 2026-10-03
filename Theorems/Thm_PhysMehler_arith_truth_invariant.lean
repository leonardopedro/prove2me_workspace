-- Generated from PhysMehler.lean — theorem PhysMehler.arith_truth_invariant
import Mathlib
import Definitions.Def_PhysMehler
import Definitions.Def_ChapterA4
open PhysMehler


open MeasureTheory Set Filter TopologicalSpace
open scoped ENNReal Topology BigOperators

noncomputable section


open PhysMeasureBasis PhysFunctionalAnalysis PhysHSGaussian

theorem PhysMehler.arith_truth_invariant {H : Type*} [NormedAddCommGroup H]
    [InnerProductSpace ℝ H] [CompleteSpace H] [MeasurableSpace H]
    (p : ℕ → ℕ → Bool) (F₁ F₂ : Formalism H) (z₁ z₂ : ZFSet) :
    interpPi02 p F₁ z₁ ↔ interpPi02 p F₂ z₂ := by sorry
