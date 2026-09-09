import Mathlib
import BookProof.ChapterQuadraticFockEsa
import BookProof.ChapterQgOuterFockEsa

/-!
# The sum-of-squares family, second quantized: `dΓ(½Σκ_jπ_j² + ½Σ_r L_r²)` is essentially
# self-adjoint on the finite-occupation core

`BookProof.ChapterQgOuterFockEsa` introduces the family
`sqSumPoly κ v = ½ Σ_j κ_j π_j² + ½ Σ_r L_r²` — a signed kinetic form (the coefficients
`κ_j` may have **either sign**, which is the physical hyperbolic signature of the
quantum-gravity kinetic term) plus a finite family of squared linear forms `L_r = Σ_i v_{ri} x_i`
(the torsion constraints of the gravity thread, the quadratic couplings of the
Navier–Stokes parcel thread).  It is the shared one-particle model of the outer-Fock
chapters, and `sqSumPoly_eq_fqPoly` identifies it with a general real quadratic Hamiltonian.

Composing that identification with `BookProof.ChapterQuadraticFockEsa`:

* **`dGamma_sqSum_essentiallySelfAdjointOn_core`** — the second quantization
  `dΓ(½Σκ_jπ_j² + ½Σ_rL_r²)`, taken in the `ℕ`-indexed product Hermite basis of `L²(ℝᴰ)`, is
  essentially self-adjoint on the finite-occupation core of the Fock space, hence has a
  unique self-adjoint realization;
* **`dGamma_sqSum_stone_flow`** — which generates a complete unitary group.

No positivity is used: the statement covers the hyperbolic signature.  What it does *not*
cover is the exponential wall potential of the scalaron sector, which is not a quadratic
symbol; for that the Faris–Lavine route of `ChapterQgOuterFockFullFL` remains the statement
of record.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SqSumFockEsa

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.FullQuadratic BookProof.QgOuterFock
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {D : ℕ}

/-- **The second quantization of the sum-of-squares one-particle Hamiltonian is essentially
self-adjoint on the finite-occupation core.**  The kinetic coefficients `κ` are of arbitrary
sign. -/
theorem dGamma_sqSum_essentiallySelfAdjointOn_core {R : Type*} [Fintype R]
    (e : ℕ ≃ (Fin D →₀ ℕ)) (kappa : Fin D → ℝ) (v : R → Fin D → ℝ) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf)
      (dGammaOp (hermCol e (sqSumPoly kappa v))) := by
  rw [sqSumPoly_eq_fqPoly]
  exact dGamma_fqPoly_essentiallySelfAdjointOn_core e _ _ _ _ _

/-- Its matrix is Hermitian. -/
theorem isHermCol_hermCol_sqSum {R : Type*} [Fintype R] (e : ℕ ≃ (Fin D →₀ ℕ))
    (kappa : Fin D → ℝ) (v : R → Fin D → ℝ) :
    IsHermCol (hermCol e (sqSumPoly kappa v)) := by
  refine isHermCol_opCol ((coreRepHerm e).symmetricOn_op ?_)
  rw [sqSumPoly_eq_fqPoly]
  exact polySym_fqPoly _ _ _ _ _

/-- **The unitary group it generates.** -/
theorem dGamma_sqSum_stone_flow {R : Type*} [Fintype R] (e : ℕ ≃ (Fin D →₀ ℕ))
    (kappa : Fin D → ℝ) (v : R → Fin D → ℝ) :
    ∃ (T : UnboundedSelfAdjoint Fock) (U : ℝ → (Fock →L[ℂ] Fock)),
      IsSelfAdjointExtension (dGammaOp (hermCol e (sqSumPoly kappa v))) T.op ∧
        IsStoneFlow T U :=
  exists_stone_flow_of_esa _ finiteOccupation_dense
    (dGammaOp_symmetricOn (isHermCol_hermCol_sqSum e kappa v))
    (dGamma_sqSum_essentiallySelfAdjointOn_core e kappa v)

end

end BookProof.SqSumFockEsa
