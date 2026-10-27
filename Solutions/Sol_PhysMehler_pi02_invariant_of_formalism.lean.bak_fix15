-- Generated from PhysMehler.lean — solution of PhysMehler.pi02_invariant_of_formalism
import Mathlib
import Definitions.Def_PhysMehler
import Theorems.Thm_PhysMehler_arith_truth_invariant
open PhysMehler



open MeasureTheory Set Filter TopologicalSpace
open scoped ENNReal Topology BigOperators

noncomputable section


open PhysMeasureBasis PhysFunctionalAnalysis PhysHSGaussian

set_option maxHeartbeats 1000000 in
theorem solution {H : Type*} [NormedAddCommGroup H]
    [InnerProductSpace ℝ H] [CompleteSpace H] [MeasurableSpace H]
    (p : ℕ → ℕ → Bool) (F₁ F₂ : Formalism H) (z : ZFSet) :
    interpPi02 p F₁ z ↔ interpPi02 p F₂ z := arith_truth_invariant p F₁ F₂ z z
