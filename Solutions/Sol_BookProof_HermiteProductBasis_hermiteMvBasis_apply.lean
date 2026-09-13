-- Generated from ChapterHermiteProductBasis.lean — solution of BookProof.HermiteProductBasis.hermiteMvBasis_apply
import Mathlib
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteProductBasis








open MeasureTheory MvPolynomial BookProof.HermiteCore BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin d →₀ ℕ) :
    hermiteMvBasis a = hermiteMvLp (d := d) a := by

  rw [hermiteMvBasis, HilbertBasis.coe_mk]
