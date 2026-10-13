-- Generated from ChapterNavierStokesDiffHashimoto.lean — solution of BookProof.NavierStokesFlow.DiffHashimoto.fieldPoly_polySym
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffHashimoto
import Theorems.Thm_BookProof_NavierStokesFlow_DiffHashimoto_polySym_sum
import Theorems.Thm_BookProof_NavierStokesFlow_DiffHashimoto_polySym_id
import Theorems.Thm_BookProof_YangMillsHermite_PolySym_add
import Theorems.Thm_BookProof_YangMillsHermite_PolySym_real_smul
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffHashimoto



open Filter Topology



open MvPolynomial
open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteRelative
open BookProof.NavierStokesFlow.DifferentialL2

open BookProof.SirkFinitePrecision BookProof.SirkFinitePrecision.CertInterval BookProof.YangMillsHermite
noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) :
    BookProof.YangMillsHermite.PolySym (fieldPoly A c i) :=
  (polySym_sum _ _ fun k _ => (polySym_mulXPoly (d := 3) k).real_smul).add
      (polySym_id.real_smul)
