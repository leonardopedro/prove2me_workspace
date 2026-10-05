import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvLp_mem_core

import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvBasis_apply

import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreEquiv_coe

import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_pgLp_smul

import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterNavierStokesSignFlip
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterYangMillsHermite
import Mathlib


/-!
# The quadrature operator `∑ᵢ (bᵢ xᵢ + b'ᵢ πᵢ)` on the Hermite core

`BookProof.ChapterHermiteRelativeBound` proves that the first-order operator
`B = ∑ᵢ (bᵢ xᵢ + b'ᵢ πᵢ)` (`foOp b b'`) is symmetric on the Gauss–polynomial
(product Hermite) core of `L²(ℝᵈ)`, and that `H_c + B` is essentially self-adjoint
whenever the quadratic part `H_c` is *elliptic*.  The shifted-core modules
(`ChapterShiftedQuadraticEsa`, `ChapterShiftedQuadraticMatrixEsa`,
`ChapterShiftedQuadraticDegenerate`) remove the sign and the invertibility
conditions by completing the square, but need a classical equilibrium — which does
not exist in a kernel direction carrying both a linear potential `bᵢxᵢ` and a
momentum term `b'ᵢπᵢ`.  There the operator has no quadratic part at all, and the
two routes used elsewhere both fail: it has no `L²` eigenvector (so the
Hermite-eigenbasis argument does not see it) and it is not constant-coefficient
(so the Fourier-multiplier argument does not see it either).
`BookProof.ChapterMixedLinearEsa` settles that operator on the **Schwartz** core, by
a quadratic gauge.  This module settles it on the **Gauss–polynomial core** — the
core the whole quadratic family lives on — by the metaplectic rotation, which on
that core is nothing but a phase.

## What is proved

* `fourier_eq_zero_of_moments`, `ae_eq_zero_of_moments'` — **a moment lemma without
  an `L²` hypothesis**: a function all of whose exponentially weighted moments are
  finite and all of whose polynomial moments vanish is zero almost everywhere.
  This strengthens `BookProof.HermiteProductCore.ae_eq_zero_of_moments`, which
  needs the function to be a Gaussian times an `L²` function, and is what lets the
  deficiency equation of a *multiplication* operator be treated on the
  Gauss–polynomial core (there the natural function is `e^{-‖x‖²/4}(ℓ − z)u`, which
  is not of that shape);
* `foOp_pos_deficiencyTrivialAt`, `foOp_pos_essentiallySelfAdjoint` — multiplication
  by the real linear function `x ↦ ⟪x, b⟫` is essentially self-adjoint on the core;
* `phaseBasis`, `phaseU`, `phaseU_hermiteMvLp` — **the instrument**: a unimodular
  multiplier on a Hilbert basis is a unitary of the space, sending each basis vector
  to its phase multiple;
* `posL_hermiteCore`, `momL_hermiteCore`, `foOp_hermiteCore` — the ladder form of the
  canonical pair on the product Hermite basis: the quadrature raises the `i`-th
  excitation number with amplitude `wᵢ = bᵢ + ib'ᵢ/2` and lowers it with `conj wᵢ`;
* `phaseU_foOp_hermiteCore` — the phase unitary rotates the canonical pair: it carries
  `foOp r 0` onto `foOp b b'` when `ζᵢ = wᵢ/|wᵢ|`, `rᵢ = |wᵢ|`.  This is the metaplectic
  rotation `e^{iθ·N}`, realized diagonally on the Hermite basis;
* HEADLINE `foOp_essentiallySelfAdjoint` — for **arbitrary** real coefficients
  `b, b'` the quadrature `∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)` is essentially self-adjoint on the
  Gauss–polynomial core of `L²(ℝᵈ)`, and `foOp_stone_flow` turns that into a
  complete unitary flow.

A reusable by-product is `linearMap_ext_of_span`: two linear maps out of a submodule
spanned by a family agree as soon as they agree on that family.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.QuadratureEsa

open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}

/-! ## 1. A moment lemma without an `L²` hypothesis -/







/-! ## 2. Multiplication by a real linear function on the Hermite core -/

/-- The real linear symbol `x ↦ ∑ᵢ bᵢxᵢ` — the multiplier of `foOp b 0`. -/
def linSymb (b : Fin d → ℝ) (x : Vd d) : ℝ := ∑ i, b i * x i

/-- The linear symbol as a polynomial. -/
noncomputable def linPoly (b : Fin d → ℝ) : MvPolynomial (Fin d) ℂ := ∑ i, C ((b i : ℝ) : ℂ) * X i











/-! ## 3. The metaplectic phase rotation on the product Hermite basis -/



theorem conj_mul_self_of_norm_one {z : ℂ} (h : ‖z‖ = 1) : (starRingEnd ℂ) z * z = 1 := by
  rw [Complex.conj_mul']
  norm_cast
  simp [h]

/-! ### The core vector carried by a product Hermite function -/

/-- The normalized product Hermite function `ψ_α`, as an element of the core. -/
noncomputable def hermiteCore (a : Fin d →₀ ℕ) : polyGaussCore (d := d) :=
  coreEquiv (((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • hermiteMv a)

@[simp] theorem hermiteCore_coe (a : Fin d →₀ ℕ) :
    ((hermiteCore a : polyGaussCore (d := d)) : L2d d) = hermiteMvLp a := by
  rw [hermiteCore, coreEquiv_coe, pgLp_smul, hermiteMvLp]



/-! ### The canonical pair in terms of the ladder operators -/

















/-! ### The complex amplitude of a quadrature -/

/-- The complex amplitude `wᵢ = bᵢ + i b'ᵢ/2` of the quadrature `bᵢxᵢ + b'ᵢπᵢ`: it is the
coefficient with which the quadrature raises the `i`-th excitation number. -/
noncomputable def foAmp (b b' : Fin d → ℝ) (i : Fin d) : ℂ :=
  ((b i : ℝ) : ℂ) + Complex.I * ((b' i : ℝ) : ℂ) / 2







/-- The modulus of the amplitude: the coefficient of the rotated, purely positional,
quadrature. -/
noncomputable def foMod (b b' : Fin d → ℝ) (i : Fin d) : ℝ := ‖foAmp b b' i‖

/-- The phase of the amplitude (set to `1` in a direction where the quadrature is absent). -/
noncomputable def foPhase (b b' : Fin d → ℝ) (i : Fin d) : ℂ :=
  if foAmp b b' i = 0 then 1 else foAmp b b' i / ((foMod b b' i : ℝ) : ℂ)







/-! ### The diagonal phase unitary -/

/-- The multi-index power `ζ^α = ∏ᵢ ζᵢ^{αᵢ}`. -/
noncomputable def phasePow (zeta : Fin d → ℂ) (a : Fin d →₀ ℕ) : ℂ := ∏ i, zeta i ^ (a i)

theorem norm_phasePow (zeta : Fin d → ℂ) (hzn : ∀ i, ‖zeta i‖ = 1) (a : Fin d →₀ ℕ) :
    ‖phasePow zeta a‖ = 1 := by
  rw [phasePow, norm_prod]
  exact Finset.prod_eq_one fun i _ => by rw [norm_pow, hzn i, one_pow]

theorem phasePow_ne_zero (zeta : Fin d → ℂ) (hzn : ∀ i, ‖zeta i‖ = 1) (a : Fin d →₀ ℕ) :
    phasePow zeta a ≠ 0 := by
  intro h
  have := norm_phasePow zeta hzn a
  rw [h] at this
  simp at this





/-- The phase-rotated product Hermite family `ζ^α ψ_α`. -/
noncomputable def phaseFamily (zeta : Fin d → ℂ) (a : Fin d →₀ ℕ) : L2d d :=
  phasePow zeta a • hermiteMvLp a

theorem orthonormal_phaseFamily (zeta : Fin d → ℂ) (hzn : ∀ i, ‖zeta i‖ = 1) :
    Orthonormal ℂ (phaseFamily (d := d) zeta) := by
  classical
  rw [orthonormal_iff_ite]
  intro a c
  rw [phaseFamily, phaseFamily, inner_smul_left, inner_smul_right,
    orthonormal_iff_ite.mp (orthonormal_hermiteMvLp (d := d)) a c]
  by_cases hac : a = c
  · subst hac
    rw [if_pos rfl, mul_one, conj_mul_self_of_norm_one (norm_phasePow zeta hzn a)]
  · rw [if_neg hac, mul_zero, mul_zero]

theorem span_phaseFamily (zeta : Fin d → ℂ) (hzn : ∀ i, ‖zeta i‖ = 1) :
    Submodule.span ℂ (Set.range (phaseFamily (d := d) zeta)) = polyGaussCore (d := d) := by
  rw [← span_hermiteMvLp]
  refine le_antisymm ?_ ?_
  · rw [Submodule.span_le]
    rintro _ ⟨a, rfl⟩
    exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨a, rfl⟩)
  · rw [Submodule.span_le]
    rintro _ ⟨a, rfl⟩
    have hrw : hermiteMvLp (d := d) a = (phasePow zeta a)⁻¹ • phaseFamily zeta a := by
      rw [phaseFamily, smul_smul, inv_mul_cancel₀ (phasePow_ne_zero zeta hzn a), one_smul]
    change hermiteMvLp (d := d) a ∈ Submodule.span ℂ (Set.range (phaseFamily (d := d) zeta))
    rw [hrw]
    exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨a, rfl⟩)

/-- The phase-rotated product Hermite functions are again a Hilbert basis. -/
noncomputable def phaseBasis (zeta : Fin d → ℂ) (hzn : ∀ i, ‖zeta i‖ = 1) :
    HilbertBasis (Fin d →₀ ℕ) ℂ (L2d d) :=
  HilbertBasis.mk (orthonormal_phaseFamily zeta hzn)
    (by
      rw [span_phaseFamily zeta hzn]
      have hd := polyGaussCore_dense (d := d)
      rw [Submodule.dense_iff_topologicalClosure_eq_top] at hd
      rw [hd])

/-- **The phase unitary**: the unitary of `L²(ℝᵈ)` which multiplies the `α`-th product
Hermite function by `ζ^α`.  For `ζᵢ = e^{iθᵢ}` this is the metaplectic rotation
`e^{iθ·N}` generated by the number operators. -/
noncomputable def phaseU (zeta : Fin d → ℂ) (hzn : ∀ i, ‖zeta i‖ = 1) : L2d d ≃ₗᵢ[ℂ] L2d d :=
  (hermiteMvBasis (d := d)).repr.trans (phaseBasis zeta hzn).repr.symm

theorem phaseU_hermiteMvLp (zeta : Fin d → ℂ) (hzn : ∀ i, ‖zeta i‖ = 1) (a : Fin d →₀ ℕ) :
    phaseU zeta hzn (hermiteMvLp (d := d) a) = phasePow zeta a • hermiteMvLp a := by
  classical
  have h1 : (hermiteMvBasis (d := d)).repr (hermiteMvLp a) = lp.single 2 a 1 := by
    rw [← hermiteMvBasis_apply]
    exact HilbertBasis.repr_self _ a
  have h2 : (phaseBasis (d := d) zeta hzn).repr.symm (lp.single 2 a 1)
      = phaseFamily (d := d) zeta a := by
    rw [HilbertBasis.repr_symm_single, phaseBasis, HilbertBasis.coe_mk]
  rw [phaseU, LinearIsometryEquiv.trans_apply, h1, h2, phaseFamily]

theorem phaseU_mem_core (zeta : Fin d → ℂ) (hzn : ∀ i, ‖zeta i‖ = 1)
    (v : polyGaussCore (d := d)) :
    phaseU zeta hzn (v : L2d d) ∈ polyGaussCore (d := d) := by
  have main : ∀ y : L2d d, y ∈ Submodule.span ℂ (Set.range (hermiteMvLp (d := d))) →
      phaseU zeta hzn y ∈ polyGaussCore (d := d) := by
    intro y hy
    induction hy using Submodule.span_induction with
    | mem z hz =>
        obtain ⟨a, rfl⟩ := hz
        rw [phaseU_hermiteMvLp]
        exact Submodule.smul_mem _ _ (hermiteMvLp_mem_core a)
    | zero => simp
    | add z w _ _ ihz ihw =>
        rw [map_add]
        exact Submodule.add_mem _ ihz ihw
    | smul r z _ ih =>
        rw [map_smul]
        exact Submodule.smul_mem _ _ ih
  exact main (v : L2d d) (by rw [span_hermiteMvLp]; exact v.2)

/-- The phase unitary, as an operator of the core. -/
noncomputable def phaseCore (zeta : Fin d → ℂ) (hzn : ∀ i, ‖zeta i‖ = 1) :
    polyGaussCore (d := d) →ₗ[ℂ] polyGaussCore (d := d) where
  toFun v := ⟨phaseU zeta hzn (v : L2d d), phaseU_mem_core zeta hzn v⟩
  map_add' u v := Subtype.ext (by simp)
  map_smul' c v := Subtype.ext (by simp)

@[simp] theorem phaseCore_coe (zeta : Fin d → ℂ) (hzn : ∀ i, ‖zeta i‖ = 1)
    (v : polyGaussCore (d := d)) :
    ((phaseCore zeta hzn v : polyGaussCore (d := d)) : L2d d) = phaseU zeta hzn (v : L2d d) := rfl

/-! ### The rotation of the quadrature -/







end BookProof.QuadratureEsa
