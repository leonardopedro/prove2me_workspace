-- Generated from ChapterYangMillsAbelianEsa.lean — solution of BookProof.YangMillsAbelianEsa.ymAbelian_positiveExtension_eq_closure
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianEsa
import Theorems.Thm_BookProof_YangMillsAbelianEsa_ymAbelian_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_EsaClosure_positiveExtension_eq_closure_of_esa
import Theorems.Thm_BookProof_YangMillsHermite_ymHamiltonian_symmetricOn
open BookProof.YangMillsAbelianEsa




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {Dom : Submodule ℂ (L2d 99)}
    {A : Dom →ₗ[ℂ] L2d 99}
    (hA : IsPositiveSelfAdjointExtension (ymHamiltonian (coreRepPoly 99) 0) A) :
    Dom = clDom (ymHamiltonian (coreRepPoly 99) 0) ∧
      ∀ (x : L2d 99) (h : x ∈ Dom) (h' : x ∈ clDom (ymHamiltonian (coreRepPoly 99) 0)),
        A ⟨x, h⟩ = clExt (ymHamiltonian (coreRepPoly 99) 0) polyGaussCore_dense
          (ymHamiltonian_symmetricOn (coreRepPoly 99) 0) ⟨x, h'⟩ :=
  positiveExtension_eq_closure_of_esa polyGaussCore_dense
      (ymHamiltonian_symmetricOn (coreRepPoly 99) 0)
      ymAbelian_essentiallySelfAdjointOn_core hA
