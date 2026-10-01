-- Generated from ChapterYangMillsAbelianFockEsa.lean — theorem BookProof.YmAbelianFock.ymAbelianFock_positiveExtension_eq_closure
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianFockEsa
open BookProof.YmAbelianFock

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs
open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime
open BookProof.FiniteSectionSingleTime BookProof.QymTimeIndependent BookProof.QgTimeIndependent

noncomputable section

variable {d : ℕ}

theorem BookProof.YmAbelianFock.ymAbelianFock_positiveExtension_eq_closure (e : ℕ ≃ (Fin 99 →₀ ℕ))
    {Dom : Submodule ℂ Fock} {A : Dom →ₗ[ℂ] Fock}
    (hA : IsPositiveSelfAdjointExtension (dGammaOp (ymAbelianHermCol e)) A) :
    Dom = clDom (dGammaOp (ymAbelianHermCol e)) ∧
      ∀ (x : Fock) (h : x ∈ Dom) (h' : x ∈ clDom (dGammaOp (ymAbelianHermCol e))),
        A ⟨x, h⟩ = clExt (dGammaOp (ymAbelianHermCol e)) finiteOccupation_dense
          (dGammaOp_ymAbelianHermCol_symmetricOn e) ⟨x, h'⟩ := by sorry
