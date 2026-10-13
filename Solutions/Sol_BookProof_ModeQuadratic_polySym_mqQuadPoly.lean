-- Generated from ChapterModeQuadraticEsa.lean — solution of BookProof.ModeQuadratic.polySym_mqQuadPoly
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
import Theorems.Thm_BookProof_HermiteRelative_polySym_sum
import Theorems.Thm_BookProof_YangMillsHermite_PolySym_add
import Theorems.Thm_BookProof_YangMillsHermite_PolySym_real_smul
import Theorems.Thm_BookProof_YangMillsHermite_weylProd_polySym
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterQuadratureEsa
import Definitions.Def_ChapterCarlemanTwoStep
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterYangMillsHermite
open BookProof.ModeQuadratic




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanTwoStep
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.YangMillsHermite

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in

theorem solution (p q s : Fin d → ℝ) :
    BookProof.YangMillsHermite.PolySym (mqQuadPoly p q s) := by
  refine polySym_sum _ _ fun i _ => ?_
  refine ((BookProof.YangMillsHermite.weylProd_polySym (polySym_momPoly i)
      (polySym_momPoly i)).real_smul.add
    (BookProof.YangMillsHermite.weylProd_polySym (polySym_mulXPoly i)
      (polySym_mulXPoly i)).real_smul).add ?_
  exact (BookProof.YangMillsHermite.weylProd_polySym (polySym_mulXPoly i)
    (polySym_momPoly i)).real_smul
