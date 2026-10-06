import Definitions.Def_ChapterCarlemanTwoStep
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterQuadratureEsa
import Definitions.Def_ChapterStoneBridge
import Mathlib


/-!
# The general mode-diagonal quadratic Hamiltonian on the Gauss–polynomial core

`BookProof.ChapterHermiteCarlemanEsa` proves essential self-adjointness, on the plain
Gauss–polynomial (product Hermite) core of `L²(ℝᵈ)`, of

`∑ᵢ cᵢ(πᵢ² + xᵢ²/4) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

for **arbitrary** real `c, b, b'`.  The quadratic part there is the *harmonic* one: in
each mode it is a multiple of the harmonic oscillator `πᵢ² + xᵢ²/4`, which is diagonal on
the Hermite basis.  The one-mode real quadratic forms make up a three-dimensional space,
spanned by `πᵢ²`, `xᵢ²` and the squeezing (dilation) generator `½(xᵢπᵢ + πᵢxᵢ)`, and
only a one-dimensional subspace of it is diagonal.

This module removes that last restriction: for **arbitrary** real `p, q, s, b, b'` the
operator

`H = ∑ᵢ (pᵢπᵢ² + qᵢxᵢ² + sᵢ·½(xᵢπᵢ + πᵢxᵢ)) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

is essentially self-adjoint on the plain Gauss–polynomial core.  Every real quadratic
Hamiltonian which does not couple distinct modes is of this form — elliptic, hyperbolic
or parabolic in each mode, with any signs, with degenerate modes allowed, and with an
arbitrary constant force and boost on top.  In particular (taking `p = q = b = b' = 0`,
`s = 1`) the generator of dilations `½∑ᵢ(xᵢπᵢ + πᵢxᵢ)` is essentially self-adjoint on the
core.

## What is proved

* `lop`, `lop_hermiteMv`, `lop_lop_hermiteMv` — the two-step ladder algebra.  Both `xᵢ`
  and `πᵢ` are of the form `aᵢ† + t aᵢ` up to a scalar, so a product of two of them moves
  the `i`-th excitation number by `0` or `±2`; the `±2` amplitudes are `√((αᵢ+1)(αᵢ+2))`
  and `√(αᵢ(αᵢ−1))`, of size `O(αᵢ)`.
* `mqQuadPoly`, `mqPoly`, `mqOp` — the Hamiltonian, assembled from Weyl-ordered products
  of the canonical pair, hence symmetric on the core (`mqOp_symmetric`).
* `mqQuadPoly_hermiteMv`, `mqOp_hermiteCore` — the ladder form of the Hamiltonian: a real
  diagonal `∑ᵢ(qᵢ + pᵢ/4)(2αᵢ+1)`, a two-step amplitude `qᵢ − pᵢ/4 + i sᵢ/2`, and the
  one-step amplitude `bᵢ + i b'ᵢ/2` of the first-order part.
* `mqOp_deficiencyTrivialAt`, `mqOp_essentiallySelfAdjoint` — **the headline**, by the
  two-step Carleman criterion `BookProof.CarlemanTwoStep.ladder2_eq_zero`.
* `mqOp_stone_flow` — the resulting complete unitary flow, by Stone's theorem.
* `dilation_essentiallySelfAdjoint`, `dilation_stone_flow` — the corollary for the
  generator of dilations.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.ModeQuadratic

open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanTwoStep
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

/-! ## 1. Two-step multi-index arithmetic -/









/-! ## 2. The two-step ladder algebra -/

/-- The generic one-step operator `aᵢ† + t aᵢ`.  Both `xᵢ = aᵢ† + aᵢ` and
`πᵢ = (i/2)(aᵢ† − aᵢ)` are of this shape. -/
def lop (t : ℂ) (i : Fin d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  crePoly i + t • annPoly i









/-! ## 3. The Hamiltonian -/

/-- The two-step (squeezing) amplitude `qᵢ − pᵢ/4 + i sᵢ/2` of the mode-diagonal
quadratic Hamiltonian: the coefficient with which it raises the `i`-th excitation number
by two. -/
def mqAmp (p q s : Fin d → ℝ) (i : Fin d) : ℂ :=
  ((q i - p i / 4 : ℝ) : ℂ) + Complex.I * ((s i / 2 : ℝ) : ℂ)

/-- The real diagonal symbol `∑ᵢ (qᵢ + pᵢ/4)(2αᵢ+1)` of the mode-diagonal quadratic
Hamiltonian. -/
def mqSymbol (p q : Fin d → ℝ) (a : Fin d →₀ ℕ) : ℝ :=
  ∑ i, (q i + p i / 4) * (2 * (a i : ℝ) + 1)

/-- The quadratic part `∑ᵢ (pᵢπᵢ² + qᵢxᵢ² + sᵢ·½(xᵢπᵢ + πᵢxᵢ))`, on polynomial
coordinates, assembled from Weyl-ordered products of the canonical pair. -/
def mqQuadPoly (p q s : Fin d → ℝ) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  ∑ i, (((p i : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (momPoly i) (momPoly i)
      + ((q i : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (mulXPoly i)
      + ((s i : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (momPoly i))

/-- The full symbol, quadratic part plus first-order part. -/
def mqPoly (p q s b b' : Fin d → ℝ) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  mqQuadPoly p q s + foPoly b b'

/-- **The general mode-diagonal quadratic Hamiltonian**
`∑ᵢ (pᵢπᵢ² + qᵢxᵢ² + sᵢ·½(xᵢπᵢ + πᵢxᵢ)) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)` on the Gauss–polynomial
core. -/
def mqOp (p q s b b' : Fin d → ℝ) : (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (polyGaussCore (d := d)).subtype ∘ₗ coreOp (mqPoly p q s b b')

/-! ### Symmetry -/







/-! ### The ladder form -/











/-! ### Transport to the core -/









/-! ## 4. Essential self-adjointness -/











end

end BookProof.ModeQuadratic
