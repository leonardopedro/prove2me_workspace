-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.momPoly_eq_cre_sub_ann
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HermiteProductBasis

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    momPoly i p = (Complex.I / 2) • (crePoly i p - annPoly i p) := by

  simp only [momPoly_apply, crePoly_apply, annPoly_apply, ← MvPolynomial.smul_eq_C_mul]
  module
