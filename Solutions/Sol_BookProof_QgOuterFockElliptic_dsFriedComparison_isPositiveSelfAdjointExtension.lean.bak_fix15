-- Generated from ChapterQgOuterFockEllipticFL.lean — solution of BookProof.QgOuterFockElliptic.dsFriedComparison_isPositiveSelfAdjointExtension
import Mathlib
import Definitions.Def_ChapterQgOuterFockEllipticFL
import Theorems.Thm_BookProof_QgOuterFockElliptic_dsCore_le_dsFriedDom
import Theorems.Thm_BookProof_QgOuterFockFL_Comparison_isPositiveSelfAdjointExtension
import Theorems.Thm_BookProof_QgOuterFockFL_friedrichsComparison_extends
open BookProof.QgOuterFockElliptic



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuantumGravity3DGauge
open BookProof.QgOuterFock
open BookProof.QgOuterFockFL
open BookProof.DirectSumEsa
open BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {D : ℕ}
variable {I : Type*} {G : I → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] [∀ i, CompleteSpace (G i)]

set_option maxHeartbeats 1000000 in
theorem solution (S : ∀ i, PosSymOp (G i))
    (hd : ∀ i, Dense ((S i).dom : Set (G i))) :
    IsPositiveSelfAdjointExtension (dsOp fun i => (S i).op) (dsFriedComparison S hd).op :=
  (dsFriedComparison S hd).isPositiveSelfAdjointExtension (dsOp fun i => (S i).op) fun x => by
      refine ⟨dsCore_le_dsFriedDom S hd x.2, ?_⟩
      refine lp.ext (funext fun i => ?_)
      refine Eq.trans (dsCompOp_fib (fun i => friedrichsComparison (S i) (hd i))
        ⟨(x : lp G 2), dsCore_le_dsFriedDom S hd x.2⟩ i) ?_
      exact (friedrichsComparison_extends (S i) (hd i) ⟨(x : lp G 2) i, x.2.2 i⟩).choose_spec
