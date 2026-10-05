import Theorems.Thm_BookProof_QuadraticRotation_orthonormal_rotHermiteLp

import Theorems.Thm_BookProof_QuadraticRotation_span_rotHermiteLp



import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterNavierStokesSignFlip
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Mathlib


/-!
# The general inhomogeneous elliptic quadratic Hamiltonian

`BookProof.ChapterQuadraticRotationEsa` proves that for **every** real symmetric matrix `A`
the quadratic Hamiltonian

`H_A = ∑_{k,l} A_{kl} (π_k π_l + x_k x_l / 4)`,  `π_k = −i ∂/∂x_k`,

is essentially self-adjoint on the Gauss–polynomial (product Hermite) core of `L²(ℝᵈ)`.
`BookProof.ChapterHermiteRelativeBound` proves that the *diagonal* Hamiltonian `H_c` with
strictly positive weights stays essentially self-adjoint after adding an arbitrary
**first-order** perturbation `B = ∑ᵢ (bᵢ xᵢ + b'ᵢ πᵢ)`, by a Kato–Rellich relative bound.

This module combines the two: for a **positive definite** real symmetric matrix `A` and
arbitrary real vectors `b, b'` the *inhomogeneous* operator

`H_A + ∑ᵢ (bᵢ xᵢ + b'ᵢ πᵢ)`

— a general elliptic quadratic form with cross terms, plus a general unbounded first-order
term — is essentially self-adjoint on the same core.  Neither the second-order part nor
the perturbation is diagonal, and the perturbation does not commute with `H_A`.

## The route

The first-order term is not diagonal in the rotated Hermite basis, so the eigenbasis
argument of `ChapterQuadraticRotationEsa` no longer applies directly.  Instead the
orthogonal substitution is upgraded to an honest **unitary** `rotU` of `L²(ℝᵈ)`: the
rotated Hermite functions are a Hilbert basis (`rotHermiteBasis`), and `rotU` is the
unitary carrying the plain Hermite basis onto it.  On the core it is the polynomial
substitution, `rotU_pgLp : rotU (p·G) = (p∘Oᵀ)·G`, so it preserves the core, carries
`H_c` onto `H_{O diag(c) Oᵀ}` and carries the first-order symbol with coefficient vectors
`b, b'` onto the one with `O b, O b'` (`rotPoly_foPoly`).  Essential self-adjointness is a
unitary invariant (`essentiallySelfAdjointOn_of_intertwine`), so the perturbed diagonal
theorem transfers.  Positive definiteness enters exactly once: it makes the eigenvalues of
`A` bounded below by a positive constant, which is the hypothesis of the Kato–Rellich
step.

## What is proved

* `rotHermiteBasis`, `rotU`, `rotU_hermiteMvLp`, `rotU_pgLp` — the rotation unitary of
  `L²(ℝᵈ)` and its action on the Gauss–polynomial core.
* `rotPoly_foPoly` — the first-order symbol transforms with the same matrix.
* `quadOpMat_add_firstOrder_essentiallySelfAdjoint` — the headline.
* `quadOpMat_add_firstOrder_symmetric` — the operator is symmetric on the core.
* `anisotropicOsc_add_linearPotential_essentiallySelfAdjoint` — the concrete corollary: an
  anisotropic harmonic oscillator with cross terms in a constant external field.
* `quadOpMat_stone_flow`, `quadOpMat_add_firstOrder_stone_flow` — the resulting complete
  unitary Schrödinger flows, via Stone's theorem.

## Boundaries

Positive definiteness of `A` is *not* removable by this route: in the indefinite case the
symbol of `H_A` vanishes on infinitely many multi-indices and no relative bound for the
first-order term holds (the same boundary as in `ChapterHermiteRelativeBound`).  The
unperturbed indefinite case is `quadOpMat_essentiallySelfAdjoint`; nothing here claims a
general potential bounded above by a quadratic (the Faris–Lavine class).
-/

namespace BookProof.QuadraticRotationPerturbed

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

noncomputable section

variable {d : ℕ}

/-! ## 1. The rotated Hermite functions as a Hilbert basis, and the rotation unitary -/

/-- The rotated product Hermite functions form a Hilbert basis of `L²(ℝᵈ)`. -/
def rotHermiteBasis {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) :
    HilbertBasis (Fin d →₀ ℕ) ℂ (L2d d) :=
  HilbertBasis.mk (orthonormal_rotHermiteLp hO)
    (by
      rw [span_rotHermiteLp hO]
      have hd := polyGaussCore_dense (d := d)
      rw [Submodule.dense_iff_topologicalClosure_eq_top] at hd
      rw [hd])

@[simp] theorem rotHermiteBasis_apply {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (a : Fin d →₀ ℕ) : rotHermiteBasis hO a = rotHermiteLp O a := by
  rw [rotHermiteBasis, HilbertBasis.coe_mk]

/-- **The rotation unitary of `L²(ℝᵈ)`**: the unitary carrying the plain product Hermite
basis onto the rotated one. -/
def rotU {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) : L2d d ≃ₗᵢ[ℂ] L2d d :=
  (hermiteMvBasis (d := d)).repr.trans (rotHermiteBasis hO).repr.symm







/-! ## 2. The first-order symbol transforms with the same matrix -/

/-- The rotated coefficient vector `(O b)ₖ = ∑ᵢ O_{ki} bᵢ`. -/
def rotVec (O : Matrix (Fin d) (Fin d) ℝ) (b : Fin d → ℝ) : Fin d → ℝ :=
  fun k => ∑ i, O k i * b i





/-! ## 3. Transfer of the perturbed theorem -/













/-! ## 4. The unitary flows -/





end

end BookProof.QuadraticRotationPerturbed
