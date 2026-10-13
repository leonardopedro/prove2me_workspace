-- Generated from ChapterModeQuadraticEsa.lean — solution of BookProof.ModeQuadratic.weyl_hermiteMv
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
import Theorems.Thm_BookProof_ModeQuadratic_lop_lop_hermiteMv
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterQuadratureEsa
import Definitions.Def_ChapterCarlemanTwoStep
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterHermiteProductCore
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
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (t t' : ℂ) (i : Fin d) (a : Fin d →₀ ℕ) :
    BookProof.YangMillsHermite.weylProd (lop t i) (lop t' i) (hermiteMv a)
      = hermiteMv (a + Finsupp.single i 2)
        + (((t + t') * ((a i : ℂ) + 1) + (t + t') * (a i : ℂ)) / 2) • hermiteMv a
        + (t * t' * (a i : ℂ) * (((a i - 1 : ℕ) : ℂ))) • hermiteMv (a - Finsupp.single i 2) := by

  rw [BookProof.YangMillsHermite.weylProd]
  simp only [LinearMap.smul_apply, LinearMap.add_apply, LinearMap.comp_apply]
  rw [lop_lop_hermiteMv t t' i a, lop_lop_hermiteMv t' t i a]
  push_cast
  module
