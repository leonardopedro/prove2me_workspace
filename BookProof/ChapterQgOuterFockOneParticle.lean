import Mathlib
import BookProof.ChapterScalaronOuterFockFL
import BookProof.ChapterQgContinuumModeInstance

/-!
# The outer Fock Hamiltonian is a one-particle operator between `a†` and `a`

The quantum-gravity Hamiltonian of `BookProof.ScalaronOuterFockFL` acts on a *Fock space of a
Fock space*: the outer Hilbert space `Sec ι = ℓ²(ι ; L²(ℝ_φ))` carries one excitation labelled
by a vielbein mode configuration `a : ι`, and the inner Hilbert space `L²(ℝ_φ)` is the
scalaron line.  The outer Hamiltonian is *number conserving* and *one-particle*: it is of the
form

`H = Σ_{a,b} a†_a  h_{ab}  a_b`,

where the one-particle kernel `h_{ab}` is an operator on the inner space.  This file makes
that structure explicit and completely elementary:

* `oneParticleOp W Q a b` is the kernel
  `h_{ab} = δ_{ab} (−d²/dφ² + φ²/4 + V(φ) + σ_b) + A_{ab} · 1 + B_{ab} · φ`,
  i.e. the fibre scalaron Hamiltonian with the **full exponential** wall on the diagonal, the
  vielbein self-interaction `A` and the scalaron–vielbein coupling `B` off it;
* `secHam_single`: applying `H` to a single-mode state `a†_b u |0⟩` gives the column
  `a ↦ h_{ab} u` of the kernel;
* `secHam_matrix_element`: `⟪a†_a v, H a†_b u⟫ = ⟪v, h_{ab} u⟫` — the promised sandwich of the
  one-particle operator between a creation operator on the left and an annihilation operator
  on the right;
* `oneParticleOp_herm`: the kernel is Hermitian, `h_{ba}^* = h_{ab}`;
* `secHam_eq_sum_oneParticle`: on the whole core, `H` is reassembled from its kernel,
  `(Hx)_a = Σ_b h_{ab} x_b`, the sum being finite because of the band structure.

Nothing here is an extra hypothesis: it is a description of the operator whose essential
self-adjointness is proved by the Faris–Lavine argument in
`BookProof.ScalaronOuterFockFL`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QgOuterFockOneParticle

open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL

noncomputable section

variable {ι : Type*} [DecidableEq ι] (W : WallPot) (Q : QgModeData ι)

/-- The single-mode state `a†_b u |0⟩` lies in the core. -/
theorem single_mem_secCore (b : ι) (u : ccDomain ℝ) :
    (lp.single 2 b ((u : L2R)) : Sec ι) ∈ secCore (ι := ι) :=
  single_mem_dsCore (G := fun _ : ι => L2R) (D := fun _ : ι => ccDomain ℝ) b u

/-- **The one-particle kernel** of the gauge-fixed quantum-gravity Hamiltonian:
`h_{ab} = δ_{ab}(−d²/dφ² + φ²/4 + V(φ) + σ_b) + A_{ab}·1 + B_{ab}·φ`, an operator from the
scalaron core to the scalaron line. -/
def oneParticleOp (a b : ι) : ccDomain ℝ →ₗ[ℂ] L2R :=
  (if a = b then W.ham (Q.sig b) else 0) + Q.A a b • (ccDomain ℝ).subtype + Q.B a b • xCc

@[simp] theorem oneParticleOp_apply (a b : ι) (u : ccDomain ℝ) :
    oneParticleOp W Q a b u
      = (if a = b then W.ham (Q.sig b) u else 0) + Q.A a b • (u : L2R) + Q.B a b • xCc u := by
  simp only [oneParticleOp, LinearMap.add_apply, LinearMap.smul_apply, Submodule.subtype_apply]
  by_cases h : a = b <;> simp [h]

/-- The kernel vanishes off the diagonal and off the band. -/
theorem oneParticleOp_off {a b : ι} (hab : a ≠ b) (hb : b ∉ Q.nbr a) :
    oneParticleOp W Q a b = 0 := by
  ext u
  simp [oneParticleOp_apply, if_neg hab, Q.A_off a b hb, Q.B_off a b hb]

/-- **The Hamiltonian applied to a single-mode state** `a†_b u |0⟩` is the `b`-th column of
the one-particle kernel. -/
theorem secHam_single (b : ι) (u : ccDomain ℝ) (a : ι) :
    (secHam W Q ⟨lp.single 2 b ((u : L2R)), single_mem_secCore b u⟩ : Sec ι) a
      = oneParticleOp W Q a b u := by
  classical
  set x : secCore (ι := ι) := ⟨lp.single 2 b ((u : L2R)), single_mem_secCore b u⟩ with hx
  have hfib : ∀ c : ι, fibOf x c = if c = b then u else 0 := by
    intro c
    by_cases hc : c = b
    · subst hc
      refine Subtype.ext ?_
      change (lp.single 2 c ((u : L2R)) : Sec ι) c = _
      rw [lp.single_apply, Pi.single_eq_same, if_pos rfl]
    · refine Subtype.ext ?_
      change (lp.single 2 b ((u : L2R)) : Sec ι) c = _
      rw [lp.single_apply, Pi.single_eq_of_ne hc, if_neg hc]
      rfl
  have hA : (∑ c ∈ Q.nbr a, Q.A a c • ((fibOf x c : ccDomain ℝ) : L2R))
      = Q.A a b • (u : L2R) := by
    by_cases hb : b ∈ Q.nbr a
    · rw [Finset.sum_eq_single b]
      · rw [hfib b, if_pos rfl]
      · intro c _ hc
        rw [hfib c, if_neg hc]
        simp
      · intro h; exact absurd hb h
    · rw [Q.A_off a b hb, zero_smul]
      refine Finset.sum_eq_zero fun c hc => ?_
      have hcb : c ≠ b := fun h => hb (h ▸ hc)
      rw [hfib c, if_neg hcb]
      simp
  have hB : (∑ c ∈ Q.nbr a, Q.B a c • xCc (fibOf x c)) = Q.B a b • xCc u := by
    by_cases hb : b ∈ Q.nbr a
    · rw [Finset.sum_eq_single b]
      · rw [hfib b, if_pos rfl]
      · intro c _ hc
        rw [hfib c, if_neg hc]
        simp
      · intro h; exact absurd hb h
    · rw [Q.B_off a b hb, zero_smul]
      refine Finset.sum_eq_zero fun c hc => ?_
      have hcb : c ≠ b := fun h => hb (h ▸ hc)
      rw [hfib c, if_neg hcb]
      simp
  rw [secHam_apply, hA, hB, oneParticleOp_apply, hfib a]
  by_cases h : a = b
  · subst h
    rw [if_pos rfl, if_pos rfl]
  · rw [if_neg h, if_neg h, map_zero]

/-- **The matrix element of the outer Hamiltonian between a creation operator on the left and
an annihilation operator on the right** is the one-particle kernel:
`⟪a†_a v, H a†_b u⟫ = ⟪v, h_{ab} u⟫`. -/
theorem secHam_matrix_element (a b : ι) (v u : ccDomain ℝ) :
    (inner ℂ (lp.single 2 a ((v : L2R)) : Sec ι)
        (secHam W Q ⟨lp.single 2 b ((u : L2R)), single_mem_secCore b u⟩ : Sec ι) : ℂ)
      = inner ℂ (v : L2R) (oneParticleOp W Q a b u) := by
  rw [lp.inner_single_left, secHam_single]

/-- **The one-particle kernel is Hermitian**: `⟪h_{ba} v, u⟫ = ⟪v, h_{ab} u⟫`. -/
theorem oneParticleOp_herm (a b : ι) (v u : ccDomain ℝ) :
    (inner ℂ (oneParticleOp W Q b a v) ((u : L2R)) : ℂ)
      = inner ℂ (v : L2R) (oneParticleOp W Q a b u) := by
  classical
  rw [oneParticleOp_apply, oneParticleOp_apply]
  simp only [inner_add_left, inner_add_right, inner_smul_left, inner_smul_right]
  have hA : (starRingEnd ℂ) (Q.A b a) = Q.A a b := by
    rw [Q.A_herm a b]; simp
  have hB : (starRingEnd ℂ) (Q.B b a) = Q.B a b := by
    rw [Q.B_herm a b]; simp
  have hx : (inner ℂ (xCc v) ((u : L2R)) : ℂ) = inner ℂ (v : L2R) (xCc u) :=
    xCc_symmetricOn v u
  rw [hA, hB, hx]
  by_cases h : a = b
  · subst h
    rw [if_pos rfl, if_pos rfl]
    rw [W.ham_symmetricOn (Q.sig a) v u]
  · rw [if_neg h, if_neg (Ne.symm h)]
    simp

/-- **The Hamiltonian is reassembled from its one-particle kernel**: `(Hx)_a = Σ_b h_{ab} x_b`,
the sum ranging over the (finite) band of `a` together with `a` itself. -/
theorem secHam_eq_sum_oneParticle (x : secCore (ι := ι)) (a : ι) :
    (secHam W Q x : Sec ι) a
      = ∑ b ∈ insert a (Q.nbr a), oneParticleOp W Q a b (fibOf x b) := by
  classical
  have key : ∀ f : ι → L2R, (∀ c, c ∉ Q.nbr a → f c = 0) →
      ∑ c ∈ insert a (Q.nbr a), f c = ∑ c ∈ Q.nbr a, f c := by
    intro f hf
    by_cases ha : a ∈ Q.nbr a
    · rw [Finset.insert_eq_self.mpr ha]
    · rw [Finset.sum_insert ha, hf a ha, zero_add]
  simp only [oneParticleOp_apply]
  rw [Finset.sum_add_distrib, Finset.sum_add_distrib,
    key (fun c => Q.A a c • ((fibOf x c : ccDomain ℝ) : L2R))
      (fun c hc => by simp [Q.A_off a c hc]),
    key (fun c => Q.B a c • xCc (fibOf x c)) (fun c hc => by simp [Q.B_off a c hc]),
    secHam_apply]
  congr 2
  rw [Finset.sum_ite_eq (insert a (Q.nbr a)) a (fun c => W.ham (Q.sig c) (fibOf x c)),
    if_pos (Finset.mem_insert_self a (Q.nbr a))]

/-! ## The physical continuum instance -/

section Continuum

open BookProof.QgContinuumModeInstance

/-- **The one-particle matrix element of the physical continuum quantum-gravity
Hamiltonian.**  With the full exponential Starobinsky wall and the infinite set of exact
Fourier modes, the outer Hamiltonian sandwiched between a creation operator on the left and
an annihilation operator on the right is the one-particle kernel: the fibre scalaron
Hamiltonian on the diagonal, the exact torsion Gram matrix as vielbein self-interaction, and
the scalaron–vielbein coupling multiplying by the scalaron field. -/
theorem starobinsky_qgContinuum_matrix_element (M alpha : ℝ) (halpha : 0 < alpha) (g : ℝ)
    (a b : CMode) (v u : ccDomain ℝ) :
    (inner ℂ (lp.single 2 a ((v : L2R)) : Sec CMode)
        (secHam (starobinskyWall M alpha halpha) (qgContinuumModes g)
          ⟨lp.single 2 b ((u : L2R)), single_mem_secCore b u⟩ : Sec CMode) : ℂ)
      = inner ℂ (v : L2R)
          ((if a = b then (starobinskyWall M alpha halpha).ham (cSig b) u else 0)
            + contTorsionGram a b • (u : L2R) + contCoupling g a b • xCc u) := by
  rw [secHam_matrix_element, oneParticleOp_apply]
  rfl

end Continuum

end

end BookProof.QgOuterFockOneParticle
