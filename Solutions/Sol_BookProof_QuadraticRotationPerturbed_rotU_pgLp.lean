-- Generated from ChapterQuadraticRotationPerturbed.lean — solution of BookProof.QuadraticRotationPerturbed.rotU_pgLp
import Mathlib
import Definitions.Def_ChapterQuadraticRotationPerturbed
import Theorems.Thm_BookProof_QuadraticRotationPerturbed_rotU_hermiteMvLp
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterNavierStokesSignFlip
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterKatoRellichDeficiency
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterHermiteProductBasis
open BookProof.QuadraticRotationPerturbed




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.NavierStokesFlow.SignFlip
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadraticRotation
open BookProof.KatoRellich
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (p : MvPolynomial (Fin d) ℂ) : rotU hO (pgLp p) = pgLp (rotPoly O p) := by

  have key : ((rotU hO).toLinearEquiv.toLinearMap ∘ₗ (pgMap (d := d)))
      = (pgMap (d := d)) ∘ₗ (rotPoly O).toLinearMap := by
    apply LinearMap.ext_on (span_hermiteMv (d := d))
    rintro _ ⟨a, rfl⟩
    change rotU hO (pgLp (hermiteMv a)) = pgLp (rotPoly O (hermiteMv a))
    rw [pgLp_hermiteMv_eq, map_smul, rotU_hermiteMvLp, rotHermiteLp, smul_smul,
      mul_inv_cancel₀ (hermiteMvNorm_ne_zero a), one_smul]
  exact congrFun (congrArg (fun T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] L2d d => (T : _ → _)) key) p
