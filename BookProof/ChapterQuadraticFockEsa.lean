import Mathlib
import BookProof.ChapterHermiteBandCalculus
import BookProof.ChapterGradedBandSchurEsa
import BookProof.ChapterFockSecondQuantization

/-!
# The second quantization of a real quadratic Hamiltonian is essentially self-adjoint on the
# finite-occupation core

This chapter joins the two halves.  `BookProof.ChapterHermiteBandCalculus` shows that a real
quadratic Hamiltonian has a graded band matrix in the product Hermite basis;
`BookProof.ChapterGradedBandSchurEsa` shows that a graded band matrix passes the weighted
Schur gates.  What is missing is the **seam**: the matrix of the operator in the `ℕ`-indexed
product Hermite basis, and the identification of its entries with the band coefficients.

## What is proved

* `hermBasisN`, `hermBasisN_apply`, `finiteModeDomain_hermBasisN`, `coreRepHerm` — the
  product Hermite basis enumerated by `ℕ`, whose finite-mode domain is exactly the
  Gauss–polynomial core, presented as a `CoreRep`.
* `hermCol` — the matrix of a polynomial operator in that basis.
* `pgLp_hcomb`, `inner_hermiteMvLp_hcomb`, `symm_equiv_hermBasisN`, `hermCol_apply`,
  **`hermCol_eq_coef`** — the matrix element `⟪ψ_{e j}, T ψ_{e k}⟫` *is* the band
  coefficient `f_{e j}` of `T ψ_{e k}`.
* **`gradedBand_of_isBand2`** — hence a second-order band operator has a graded band matrix,
  with `D = 2` and the grading `deg k = |e k|`.
* **`dGamma_hermCol_essentiallySelfAdjointOn_core`** and
  **`dGamma_fqPoly_essentiallySelfAdjointOn_core`** — the headlines: for a symmetric
  second-order band operator, and in particular for the general real quadratic Hamiltonian
  `fqPoly P Q S b b'`, the second quantization `dΓ(H₁)` is essentially self-adjoint on the
  finite-occupation core of the Fock space over `L²(ℝᵈ)`.

The one-particle operator here is genuinely **unbounded** — a quadratic Hamiltonian has
matrix elements growing like the degree — so this is outside the reach of the unweighted
Schur gate of `BookProof.ChapterFockSchurEsa`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QuadFockEsa

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable {d : ℕ}

/-! ## The product Hermite basis, indexed by `ℕ` -/

theorem span_hermiteMvLp_comp (e : ℕ ≃ (Fin d →₀ ℕ)) :
    Submodule.span ℂ (Set.range (hermiteMvLp (d := d) ∘ e)) = polyGaussCore (d := d) := by
  rw [Set.range_comp, e.surjective.range_eq, Set.image_univ, span_hermiteMvLp]

/-- The product Hermite basis of `L²(ℝᵈ)`, enumerated by `ℕ`. -/
def hermBasisN (e : ℕ ≃ (Fin d →₀ ℕ)) : HilbertBasis ℕ ℂ (L2d d) :=
  HilbertBasis.mk (orthonormal_hermiteMvLp.comp e e.injective)
    (by
      rw [span_hermiteMvLp_comp e]
      have hd := polyGaussCore_dense (d := d)
      rw [Submodule.dense_iff_topologicalClosure_eq_top] at hd
      rw [hd])

@[simp] theorem hermBasisN_apply (e : ℕ ≃ (Fin d →₀ ℕ)) (k : ℕ) :
    hermBasisN e k = hermiteMvLp (e k) := by
  rw [hermBasisN, HilbertBasis.coe_mk]
  rfl

theorem range_hermBasisN (e : ℕ ≃ (Fin d →₀ ℕ)) :
    Set.range (hermBasisN e) = Set.range (hermiteMvLp (d := d)) := by
  ext x
  constructor
  · rintro ⟨k, rfl⟩
    exact ⟨e k, by rw [hermBasisN_apply]⟩
  · rintro ⟨α, rfl⟩
    exact ⟨e.symm α, by rw [hermBasisN_apply]; simp⟩

theorem finiteModeDomain_hermBasisN (e : ℕ ≃ (Fin d →₀ ℕ)) :
    finiteModeDomain (hermBasisN e) = polyGaussCore (d := d) := by
  rw [finiteModeDomain, range_hermBasisN, span_hermiteMvLp]

/-- The finite-mode domain of the enumerated product Hermite basis is a `CoreRep`. -/
def coreRepHerm (e : ℕ ≃ (Fin d →₀ ℕ)) : CoreRep d (finiteModeDomain (hermBasisN e)) :=
  CoreRep.ofRangeEq (finiteModeDomain_hermBasisN e).symm

/-- The matrix of a polynomial operator in the enumerated product Hermite basis. -/
def hermCol (e : ℕ ≃ (Fin d →₀ ℕ)) (T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    ℕ → (ℕ →₀ ℂ) :=
  opCol (hermBasisN e) ((coreRepHerm e).op T)

/-! ## The matrix elements are the band coefficients -/

theorem pgLp_hcomb (f : (Fin d →₀ ℕ) →₀ ℂ) :
    pgLp (hcomb f) = ∑ γ ∈ f.support, f γ • hermiteMvLp γ := by
  rw [hcomb, Finsupp.linearCombination_apply, Finsupp.sum, ← HermiteProductCore.pgMap_apply,
    map_sum]
  exact Finset.sum_congr rfl fun γ _ => by
    rw [map_smul, HermiteProductCore.pgMap_apply, pgLp_hpsi]

theorem inner_hermiteMvLp_hcomb (f : (Fin d →₀ ℕ) →₀ ℂ) (β : Fin d →₀ ℕ) :
    (inner ℂ (hermiteMvLp β) (pgLp (hcomb f)) : ℂ) = f β := by
  classical
  rw [pgLp_hcomb, inner_sum]
  have hterm : ∀ γ ∈ f.support,
      (inner ℂ (hermiteMvLp β) (f γ • hermiteMvLp γ) : ℂ) = if β = γ then f γ else 0 := by
    intro γ _
    rw [inner_smul_right, inner_hermiteMvLp]
    split <;> simp_all
  rw [Finset.sum_congr rfl hterm, Finset.sum_ite_eq f.support β f]
  split
  · rfl
  · exact (Finsupp.notMem_support_iff.mp (by assumption)).symm

theorem symm_equiv_hermBasisN (e : ℕ ≃ (Fin d →₀ ℕ)) (k : ℕ) :
    (coreRepHerm e).equiv.symm ⟨hermBasisN e k, Submodule.subset_span ⟨k, rfl⟩⟩ = hpsi (e k) := by
  have h1 : pgLp ((coreRepHerm e).equiv.symm
      ⟨hermBasisN e k, Submodule.subset_span ⟨k, rfl⟩⟩) = hermiteMvLp (e k) := by
    rw [← (coreRepHerm e).coe_symm]
    simp
  have h2 : pgLp (hpsi (e k)) = hermiteMvLp (e k) := pgLp_hpsi (e k)
  exact pgMap_injective (by rw [HermiteProductCore.pgMap_apply, HermiteProductCore.pgMap_apply,
    h1, h2])

theorem hermCol_apply (e : ℕ ≃ (Fin d →₀ ℕ)) (T : Module.End ℂ (MvPolynomial (Fin d) ℂ))
    (k j : ℕ) :
    hermCol e T k j = (inner ℂ (hermiteMvLp (e j)) (pgLp (T (hpsi (e k)))) : ℂ) := by
  rw [hermCol, opCol_apply, CoreRep.coe_op, symm_equiv_hermBasisN, hermBasisN_apply]

/-- The matrix element of a band operator is the band coefficient. -/
theorem hermCol_eq_coef (e : ℕ ≃ (Fin d →₀ ℕ)) {T : Module.End ℂ (MvPolynomial (Fin d) ℂ)}
    {f : (Fin d →₀ ℕ) →₀ ℂ} {k : ℕ} (hf : T (hpsi (e k)) = hcomb f) (j : ℕ) :
    hermCol e T k j = f (e j) := by
  rw [hermCol_apply, hf, inner_hermiteMvLp_hcomb]

/-! ## A second-order band operator has a graded band matrix -/

theorem gradedBand_of_isBand2 (e : ℕ ≃ (Fin d →₀ ℕ))
    {T : Module.End ℂ (MvPolynomial (Fin d) ℂ)} (h : IsBand2 T) :
    ∃ (M : ℕ) (C : ℝ), 0 ≤ C ∧
      (∀ k, (hermCol e T k).support.card ≤ M) ∧
      (∀ k, ∀ j ∈ (hermCol e T k).support,
        (((e j).degree : ℤ) - ((e k).degree : ℤ)).natAbs ≤ 2) ∧
      (∀ k j, ‖hermCol e T k j‖ ≤ C * (((e k).degree : ℝ) + 1)) := by
  classical
  obtain ⟨M, C, hC, hB⟩ := h
  choose F hFrep hFcard hFband hFcoef using fun α => hB α
  refine ⟨M, C, hC, ?_, ?_, ?_⟩
  · intro k
    have hsub : ∀ j ∈ (hermCol e T k).support, e j ∈ (F (e k)).support := by
      intro j hj
      have hne : hermCol e T k j ≠ 0 := Finsupp.mem_support_iff.mp hj
      rw [hermCol_eq_coef e (hFrep (e k)) j] at hne
      exact Finsupp.mem_support_iff.mpr hne
    refine le_trans (Finset.card_le_card_of_injOn e hsub ?_) (hFcard (e k))
    exact fun a _ b _ hab => e.injective hab
  · intro k j hj
    have hne : hermCol e T k j ≠ 0 := Finsupp.mem_support_iff.mp hj
    rw [hermCol_eq_coef e (hFrep (e k)) j] at hne
    exact hFband (e k) (e j) (Finsupp.mem_support_iff.mpr hne)
  · intro k j
    rw [hermCol_eq_coef e (hFrep (e k)) j]
    exact hFcoef (e k) (e j)

/-! ## The headline -/

/-- **The second quantization of a second-order band operator is essentially self-adjoint
on the finite-occupation core.** -/
theorem dGamma_hermCol_essentiallySelfAdjointOn_core (e : ℕ ≃ (Fin d →₀ ℕ))
    {T : Module.End ℂ (MvPolynomial (Fin d) ℂ)} (hsym : PolySym T) (h : IsBand2 T) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp (hermCol e T)) := by
  obtain ⟨M, C, hC, hcard, hband, hent⟩ := gradedBand_of_isBand2 e h
  exact dGamma_essentiallySelfAdjointOn_core_gradedBand (deg := fun k => (e k).degree)
    (D := 2) (M := M) hC (isHermCol_opCol ((coreRepHerm e).symmetricOn_op hsym))
    hcard hband hent

/-- **The second quantization of a general real quadratic Hamiltonian is essentially
self-adjoint on the finite-occupation core.** -/
theorem dGamma_fqPoly_essentiallySelfAdjointOn_core (e : ℕ ≃ (Fin d →₀ ℕ))
    (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf)
      (dGammaOp (hermCol e (fqPoly P Q S b b'))) :=
  dGamma_hermCol_essentiallySelfAdjointOn_core e (polySym_fqPoly P Q S b b')
    (isBand2_fqPoly P Q S b b')

end

end BookProof.QuadFockEsa
