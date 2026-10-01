import Definitions.Def_ChapterHermiteGraphApprox
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterEsaOneParticleDGamma
import Mathlib


/-!
# The non-abelian Yang–Mills one-particle Hamiltonian is essentially self-adjoint

The tree had essential self-adjointness of the gauge-fixed Yang–Mills Hamiltonian only in the
abelian (quadratic) case (`BookProof/ChapterYangMillsAbelianEsa.lean`).  The Kato-type
theorem of `BookProof/ChapterDegKatoEsa.lean` and its transfer to the Gauss–polynomial core
(`BookProof/ChapterHermiteGraphApprox.lean`) hold for an arbitrary real polynomial potential
`W ≥ 1` and an arbitrary set `S` of momentum-carrying coordinates.  This module instantiates
them for the **non-abelian** Hamiltonian `ymHamiltonian`, for arbitrary real structure
constants `f_{abc}`:

* `deficiencyTrivialAt_of_esa` — for a symmetric operator on a Hilbert space, trivial
  deficiency at `± i` gives trivial deficiency at every non-real point;
* `essentiallySelfAdjointOn_affine` — hence `a • K + b` (`a > 0`, `b` real) is essentially
  self-adjoint whenever `K` is;
* `weylPoly_eq_hamCoreS`, `weylPoly_esa` — any Weyl-type operator `½ Σ_m π_{idx m}² + ½ Σ_j Φ_j²`
  on the Gauss–polynomial core, with momenta in distinct coordinates and real polynomial
  fields `Φ_j`, satisfies `2H + 1 = −Δ_S + W` with `W = Σ_j Φ_j² + 1`, hence is essentially
  self-adjoint;
* `ymHamiltonian_eq_weylPoly` — the non-abelian Yang–Mills Hamiltonian is such an operator,
  with `S` the 24 gauge-field coordinates `A_{j,a}` and `Φ` the 24 magnetic fields `B_{ia}`;
* **`ym_h_esa`** — the non-abelian gauge-fixed Yang–Mills one-particle Hamiltonian
  `H = ½ Σ π² + ½ Σ B²` is essentially self-adjoint on the Gauss–polynomial core of `L²(ℝ⁹⁹)`;
* **`ym_dGamma_esa`** — its second quantization `dΓ(H)` (one-particle `H` enclosed between a
  creation on the left and an annihilation on the right) is essentially self-adjoint on the
  finite-particle domain over that core, by the lift of `BookProof/ChapterEsaOneParticleDGamma`.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.YangMillsNonAbelianEsa

open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore

noncomputable section

/-! ## 1. Essential self-adjointness is stable under positive affine maps -/

section Abstract

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {D : Submodule ℂ F}





end Abstract

/-! ## 2. Transport of polynomial operators to the core, in any dimension -/

section Transport

variable {d : ℕ}









end Transport

/-! ## 3. A Weyl-type operator with polynomial fields is a degenerate Schrödinger operator -/

section General

variable {d k r : ℕ}

/-- The Weyl-type operator `½ Σ_m π_{idx m}² + ½ Σ_j Φ_j²` on the Gauss–polynomial core of
`L²(ℝᵈ)`: momenta in the coordinates `idx m`, multiplication by the polynomials `Φ_j`. -/
def weylPoly (idx : Fin k → Fin d) (Φ : Fin r → MvPolynomial (Fin d) ℂ) :
    (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  weylOp (fun m => (coreRepPoly d).op (momOp (idx m))) (fun j => (coreRepPoly d).op (mulOp (Φ j)))

/-- The potential `W = Σ_j Φ_j² + 1`. -/
def weylPotPoly (Φ : Fin r → MvPolynomial (Fin d) ℂ) : MvPolynomial (Fin d) ℂ :=
  (∑ j : Fin r, Φ j * Φ j) + C ((1 : ℝ) : ℂ)













end General

/-! ## 4. The non-abelian Yang–Mills instance -/

/-- The coordinate of the `m`-th gauge-field component `A_{j,a}`. -/
def ymIdx (m : Fin 24) : Fin 99 := idxA (decodeSpace m) (decodeColor m)



/-- The `m`-th magnetic-field polynomial `B_{ia}`. -/
def ymMag (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (m : Fin 24) : MvPolynomial (Fin 99) ℂ :=
  magPoly fabc (decodeSpace m) (decodeColor m)





/-- `L²(ℝᵈ)` as a bundled inner product space, the one-particle space of the enclosure. -/
def L2dSpace (d : ℕ) : IPSpace := ⟨L2d d⟩

instance (d : ℕ) : CompleteSpace (L2dSpace d).carrier :=
  inferInstanceAs (CompleteSpace (L2d d))



end

end BookProof.YangMillsNonAbelianEsa
