-- Generated from ChapterQuadraticRotationPerturbed.lean — solution of BookProof.QuadraticRotationPerturbed.rotU_hermiteMvLp
import Mathlib
import Definitions.Def_ChapterQuadraticRotationPerturbed
import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvBasis_apply
open BookProof.QuadraticRotationPerturbed




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadraticRotation
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) (a : Fin d →₀ ℕ) :
    rotU hO (hermiteMvLp (d := d) a) = rotHermiteLp O a := by

  rw [rotU, LinearIsometryEquiv.trans_apply, ← hermiteMvBasis_apply,
    HilbertBasis.repr_self, HilbertBasis.repr_symm_single, rotHermiteBasis_apply]
