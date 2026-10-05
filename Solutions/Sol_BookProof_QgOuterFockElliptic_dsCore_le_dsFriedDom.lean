-- Generated from ChapterQgOuterFockEllipticFL.lean — solution of BookProof.QgOuterFockElliptic.dsCore_le_dsFriedDom
import Mathlib
import Definitions.Def_ChapterQgOuterFockEllipticFL
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
    dsCore (fun i => (S i).dom) ≤ (dsFriedComparison S hd).dom := by

  intro x hx
  refine ⟨fun i =>
    (friedrichsComparison_extends (S i) (hd i) ⟨(x : lp G 2) i, hx.2 i⟩).choose, ?_⟩
  have hfun : (fun i => opTot (friedrichsComparison (S i) (hd i)).op ((x : lp G 2) i))
      = fun i => ((S i).op ⟨(x : lp G 2) i, hx.2 i⟩ : G i) := by
    funext i
    rw [opTot_of_mem _
      (friedrichsComparison_extends (S i) (hd i) ⟨(x : lp G 2) i, hx.2 i⟩).choose]
    exact (friedrichsComparison_extends (S i) (hd i) ⟨(x : lp G 2) i, hx.2 i⟩).choose_spec
  rw [hfun]
  refine memLp_of_finite_support (Set.Finite.subset hx.1 fun i hi => ?_)
  simp only [Set.mem_setOf_eq] at hi ⊢
  intro h0
  refine hi ?_
  have hz : (⟨(x : lp G 2) i, hx.2 i⟩ : (S i).dom) = 0 := Subtype.ext h0
  rw [hz, map_zero]
