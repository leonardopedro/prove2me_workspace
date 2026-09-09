-- Generated from ChapterNavierStokesDiffHashimoto.lean — solution of BookProof.NavierStokesFlow.DiffHashimoto.nsDiffPoly_polySym
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffHashimoto
import Theorems.Thm_BookProof_NavierStokesFlow_DiffHashimoto_polySym_sum
import Theorems.Thm_BookProof_NavierStokesFlow_DiffHashimoto_fieldPoly_polySym
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffHashimoto








open Filter Topology



open MvPolynomial
open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteRelative
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution : BookProof.YangMillsHermite.PolySym (nsDiffPoly A c) :=
  polySym_sum _ _ fun i _ =>
      BookProof.YangMillsHermite.weylProd_polySym (polySym_momPoly (d := 3) i)
        (fieldPoly_polySym A c i)
