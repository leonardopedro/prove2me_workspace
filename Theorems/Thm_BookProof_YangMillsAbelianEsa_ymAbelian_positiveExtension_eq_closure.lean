-- Generated from ChapterYangMillsAbelianEsa.lean — theorem BookProof.YangMillsAbelianEsa.ymAbelian_positiveExtension_eq_closure
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianEsa
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

theorem BookProof.YangMillsAbelianEsa.ymAbelian_positiveExtension_eq_closure {Dom : Submodule ℂ (L2d 99)}
    {A : Dom →ₗ[ℂ] L2d 99}
    (hA : IsPositiveSelfAdjointExtension (ymHamiltonian (coreRepPoly 99) 0) A) :
    Dom = clDom (ymHamiltonian (coreRepPoly 99) 0) ∧
      ∀ (x : L2d 99) (h : x ∈ Dom) (h' : x ∈ clDom (ymHamiltonian (coreRepPoly 99) 0)),
        A ⟨x, h⟩ = clExt (ymHamiltonian (coreRepPoly 99) 0) polyGaussCore_dense
          (ymHamiltonian_symmetricOn (coreRepPoly 99) 0) ⟨x, h'⟩ := by sorry
