import Definitions.Def_ChapterCarlemanTwoStep
import Definitions.Def_ChapterHermiteCarlemanEsa
import Mathlib


/-!
# A Carleman criterion for general lattice hops

`BookProof.ChapterHermiteCarlemanEsa` and `BookProof.ChapterCarlemanTwoStep` prove
Carleman (flux) criteria for recursions whose hops move a **single** excitation number,
by one or by two.  That covers every **mode-diagonal** quadratic Hamiltonian.  A quadratic
Hamiltonian which couples two *distinct* modes — `xᵢxⱼ`, `πᵢπⱼ`, `xᵢπⱼ` with `i ≠ j` —
produces hops `α ↦ α ± (eᵢ + eⱼ)` and `α ↦ α ± (eᵢ − eⱼ)`, and the second kind is **not**
monotone: the shift lowers one coordinate while raising another.

This module runs the flux argument for a hop of the completely general shape
`α ↦ α + p − m` (`hshift`), with `p` and `m` multi-indices.

## What is proved

* `hshift`, `hshift_hshift` — the shift and its inverse on the set where it is defined.
* `rtG`, `ltG`, `hopB`, `sum_ltG`, `sum_hop_im` — **the abstract flux cancellation.**  For
  a Hermitian hop family, the contributions from pairs `α, α + p − m` which both lie in a
  finite set `A` cancel in the imaginary part, so the imaginary part of the total is
  carried by two boundary layers: the *outgoing* layer `A \ B` (points of `A` whose image
  leaves `A`) and the *incoming* layer `B \ A` (points outside `A` whose image lands in
  `A`).  For a monotone hop (`m = 0`) the incoming layer is empty and this specialises to
  the situation of the two earlier modules.
-/

namespace BookProof.CarlemanGeneralHop

open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

/-! ## 1. The general shift -/

/-- The lattice hop `α ↦ α + p − m` (truncated subtraction; it is used only where
`m ≤ α`). -/
def hshift (p m a : Fin d →₀ ℕ) : Fin d →₀ ℕ := a + p - m







/-! ## 2. The abstract flux cancellation -/

variable {u : (Fin d →₀ ℕ) → ℂ}

/-- The raising contribution of the hop `α ↦ α + p − m`. -/
def rtG (u : (Fin d →₀ ℕ) → ℂ) (w : ℂ) (c : (Fin d →₀ ℕ) → ℝ) (p m a : Fin d →₀ ℕ) : ℂ :=
  (starRingEnd ℂ) w * ((c a : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (hshift p m a)

/-- The lowering contribution, i.e. the contribution of the opposite hop
`α ↦ α − p + m`. -/
def ltG (u : (Fin d →₀ ℕ) → ℂ) (w : ℂ) (c' : (Fin d →₀ ℕ) → ℝ) (p m a : Fin d →₀ ℕ) : ℂ :=
  w * ((c' a : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (hshift m p a)

/-- The set of points that hop **into** `A`. -/
def hopB (A : Finset (Fin d →₀ ℕ)) (p m : Fin d →₀ ℕ) : Finset (Fin d →₀ ℕ) :=
  (A.filter (fun a => ∀ k, p k ≤ a k)).image (hshift m p)









/-! ## 3. The boundary layers of a cube -/

/-- The **outgoing** boundary layer of the cube for the hop `α ↦ α + p − m`: the points of
the cube at which the hop is defined and some coordinate is within `p` of the top. -/
def obd (d N : ℕ) (p m : Fin d →₀ ℕ) : Finset (Fin d →₀ ℕ) :=
  (cube d N).filter (fun a => (∀ k, m k ≤ a k) ∧ ∃ k, N < a k + p k)

/-- The **incoming** boundary layer: points just outside the cube whose hop image can land
inside it.  It is empty for a monotone hop (`m = 0`). -/
def ibd (d N : ℕ) (m : Fin d →₀ ℕ) : Finset (Fin d →₀ ℕ) :=
  (cube d (N + 1)).filter (fun b => (∀ k, m k ≤ b k) ∧ ¬ (∀ k, b k ≤ N))









/-! ## 4. The flux bound -/



/-! ## 5. Bessel's inequality for the two boundary layers -/





adratic Hamiltonian.  A quadratic
Hamiltonian which couples two *distinct* modes — `xᵢxⱼ`, `πᵢπⱼ`, `xᵢπⱼ` with `i ≠ j` —
produces hops `α ↦ α ± (eᵢ + eⱼ)` and `α ↦ α ± (eᵢ − eⱼ)`, and the second kind is **not**
monotone: the shift lowers one coordinate while raising another.

This module runs the flux argument for a hop of the completely general shape
`α ↦ α + p − m` (`hshift`), with `p` and `m` multi-indices.

## What is proved

* `hshift`, `hshift_hshift` — the shift and its inverse on the set where it is defined.
* `rtG`, `ltG`, `hopB`, `sum_ltG`, `sum_hop_im` — **the abstract flux cancellation.**  For
  a Hermitian hop family, the contributions from pairs `α, α + p − m` which both lie in a
  finite set `A` cancel in the imaginary part, so the imaginary part of the total is
  carried by two boundary layers: the *outgoing* layer `A \ B` (points of `A` whose image
  leaves `A`) and the *incoming* layer `B \ A` (points outside `A` whose image lands in
  `A`).  For a monotone hop (`m = 0`) the incoming layer is empty and this specialises to
  the situation of the two earlier modules.
-/

namespace BookProof.CarlemanGeneralHop

open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

/-! ## 1. The general shift -/

/-- The lattice hop `α ↦ α + p − m` (truncated subtraction; it is used only where
`m ≤ α`). -/
def hshift (p m a : Fin d →₀ ℕ) : Fin d →₀ ℕ := a + p - m

theorem hshift_apply (p m a : Fin d →₀ ℕ) (k : Fin d) :
    hshift p m a k = a k + p k - m k := by
  simp [hshift, Finsupp.tsub_apply]

/-- Where the hop is defined it is inverted by the opposite hop. -/
theorem hshift_hshift {p m a : Fin d →₀ ℕ} (h : ∀ k, m k ≤ a k) :
    hshift m p (hshift p m a) = a := by
  ext k
  rw [hshift_apply, hshift_apply]
  have := h k
  omega

theorem hshift_le {p m a : Fin d →₀ ℕ} (h : ∀ k, m k ≤ a k) (k : Fin d) :
    p k ≤ hshift p m a k := by
  rw [hshift_apply]
  have := h k
  omega

/-! ## 2. The abstract flux cancellation -/

variable {u : (Fin d →₀ ℕ) → ℂ}

/-- The raising contribution of the hop `α ↦ α + p − m`. -/
def rtG (u : (Fin d →₀ ℕ) → ℂ) (w : ℂ) (c : (Fin d →₀ ℕ) → ℝ) (p m a : Fin d →₀ ℕ) : ℂ :=
  (starRingEnd ℂ) w * ((c a : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (hshift p m a)

/-- The lowering contribution, i.e. the contribution of the opposite hop
`α ↦ α − p + m`. -/
def ltG (u : (Fin d →₀ ℕ) → ℂ) (w : ℂ) (c' : (Fin d →₀ ℕ) → ℝ) (p m a : Fin d →₀ ℕ) : ℂ :=
  w * ((c' a : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (hshift m p a)

/-- The set of points that hop **into** `A`. -/
def hopB (A : Finset (Fin d →₀ ℕ)) (p m : Fin d →₀ ℕ) : Finset (Fin d →₀ ℕ) :=
  (A.filter (fun a => ∀ k, p k ≤ a k)).image (hshift m p)

theorem mem_hopB {A : Finset (Fin d →₀ ℕ)} {p m b : Fin d →₀ ℕ} :
    b ∈ hopB A p m ↔ (∀ k, m k ≤ b k) ∧ hshift p m b ∈ A := by
  classical
  constructor
  · intro hb
    rw [hopB, Finset.mem_image] at hb
    obtain ⟨a, ha, rfl⟩ := hb
    rw [Finset.mem_filter] at ha
    refine ⟨fun k => hshift_le ha.2 k, ?_⟩
    rw [hshift_hshift ha.2]
    exact ha.1
  · rintro ⟨hm, hA⟩
    rw [hopB, Finset.mem_image]
    refine ⟨hshift p m b, ?_, ?_⟩
    · rw [Finset.mem_filter]
      exact ⟨hA, fun k => hshift_le hm k⟩
    · rw [hshift_hshift hm]

theorem ltG_eq_conj_rtG {w : ℂ} {c c' : (Fin d →₀ ℕ) → ℝ} {p m a : Fin d →₀ ℕ}
    (hcomp : ∀ b : Fin d →₀ ℕ, (∀ k, m k ≤ b k) → c' (hshift p m b) = c b)
    (ha : ∀ k, p k ≤ a k) :
    ltG u w c' p m a = (starRingEnd ℂ) (rtG u w c p m (hshift m p a)) := by
  have hb : ∀ k, m k ≤ hshift m p a k := fun k => hshift_le ha k
  have hba : hshift p m (hshift m p a) = a := hshift_hshift ha
  rw [ltG, rtG, hba]
  rw [show c' a = c (hshift m p a) from by
    conv_lhs => rw [← hba]
    exact hcomp _ hb]
  simp only [map_mul, Complex.conj_conj, Complex.conj_ofReal]
  ring

/-- The lowering sum over `A` is the conjugate of the raising sum over `hopB A p m`. -/
theorem sum_ltG {w : ℂ} {c c' : (Fin d →₀ ℕ) → ℝ} {p m : Fin d →₀ ℕ}
    (hcomp : ∀ b : Fin d →₀ ℕ, (∀ k, m k ≤ b k) → c' (hshift p m b) = c b)
    (hvanL : ∀ a : Fin d →₀ ℕ, ¬ (∀ k, p k ≤ a k) → c' a = 0) (A : Finset (Fin d →₀ ℕ)) :
    ∑ a ∈ A, ltG u w c' p m a
      = (starRingEnd ℂ) (∑ b ∈ hopB A p m, rtG u w c p m b) := by
  classical
  have hfil : ∑ a ∈ A, ltG u w c' p m a
      = ∑ a ∈ A.filter (fun a => ∀ k, p k ≤ a k), ltG u w c' p m a := by
    refine (Finset.sum_filter_of_ne ?_).symm
    intro a _ hne
    by_contra hlt
    exact hne (by rw [ltG, hvanL a hlt]; simp)
  rw [hfil, hopB, Finset.sum_image, map_sum]
  · refine Finset.sum_congr rfl fun a ha => ?_
    rw [Finset.mem_filter] at ha
    exact ltG_eq_conj_rtG hcomp ha.2
  · intro x hx y hy hxy
    simp only [Finset.mem_coe, Finset.mem_filter] at hx hy
    have := congrArg (hshift p m) hxy
    rwa [hshift_hshift hx.2, hshift_hshift hy.2] at this

/-- **The flux cancellation for a general hop.**  Only the outgoing layer `A \ B` and the
incoming layer `B \ A` contribute to the imaginary part. -/
theorem sum_hop_im {w : ℂ} {c c' : (Fin d →₀ ℕ) → ℝ} {p m : Fin d →₀ ℕ}
    (hcomp : ∀ b : Fin d →₀ ℕ, (∀ k, m k ≤ b k) → c' (hshift p m b) = c b)
    (hvanL : ∀ a : Fin d →₀ ℕ, ¬ (∀ k, p k ≤ a k) → c' a = 0) (A : Finset (Fin d →₀ ℕ)) :
    (∑ a ∈ A, (rtG u w c p m a + ltG u w c' p m a)).im
      = (∑ a ∈ A \ hopB A p m, rtG u w c p m a).im
        - (∑ b ∈ hopB A p m \ A, rtG u w c p m b).im := by
  classical
  set B := hopB A p m with hB
  have hsplitA : ∑ a ∈ A, rtG u w c p m a
      = ∑ a ∈ A ∩ B, rtG u w c p m a + ∑ a ∈ A \ B, rtG u w c p m a :=
    (Finset.sum_inter_add_sum_sdiff A B _).symm
  have hsplitB : ∑ a ∈ B, rtG u w c p m a
      = ∑ a ∈ A ∩ B, rtG u w c p m a + ∑ a ∈ B \ A, rtG u w c p m a := by
    rw [Finset.inter_comm]
    exact (Finset.sum_inter_add_sum_sdiff B A _).symm
  rw [Finset.sum_add_distrib, sum_ltG hcomp hvanL A, ← hB, Complex.add_im,
    Complex.conj_im, hsplitA, hsplitB]
  simp only [Complex.add_im]
  ring

/-! ## 3. The boundary layers of a cube -/

/-- The **outgoing** boundary layer of the cube for the hop `α ↦ α + p − m`: the points of
the cube at which the hop is defined and some coordinate is within `p` of the top. -/
def obd (d N : ℕ) (p m : Fin d →₀ ℕ) : Finset (Fin d →₀ ℕ) :=
  (cube d N).filter (fun a => (∀ k, m k ≤ a k) ∧ ∃ k, N < a k + p k)

/-- The **incoming** boundary layer: points just outside the cube whose hop image can land
inside it.  It is empty for a monotone hop (`m = 0`). -/
def ibd (d N : ℕ) (m : Fin d →₀ ℕ) : Finset (Fin d →₀ ℕ) :=
  (cube d (N + 1)).filter (fun b => (∀ k, m k ≤ b k) ∧ ¬ (∀ k, b k ≤ N))

theorem mem_obd {N : ℕ} {p m a : Fin d →₀ ℕ} :
    a ∈ obd d N p m ↔ (∀ k, a k ≤ N) ∧ (∀ k, m k ≤ a k) ∧ ∃ k, N < a k + p k := by
  classical
  rw [obd, Finset.mem_filter, mem_cube]

theorem mem_ibd {N : ℕ} {m b : Fin d →₀ ℕ} :
    b ∈ ibd d N m ↔ (∀ k, b k ≤ N + 1) ∧ (∀ k, m k ≤ b k) ∧ ¬ (∀ k, b k ≤ N) := by
  classical
  rw [ibd, Finset.mem_filter, mem_cube]

/-- Outside the outgoing layer the outgoing flux vanishes. -/
theorem amp_eq_zero_of_not_mem_obd {N : ℕ} {p m : Fin d →₀ ℕ} {c : (Fin d →₀ ℕ) → ℝ}
    (hvanR : ∀ a : Fin d →₀ ℕ, ¬ (∀ k, m k ≤ a k) → c a = 0) {a : Fin d →₀ ℕ}
    (ha : a ∈ cube d N \ hopB (cube d N) p m) (hne : a ∉ obd d N p m) : c a = 0 := by
  classical
  rw [Finset.mem_sdiff] at ha
  by_cases hm : ∀ k, m k ≤ a k
  · exfalso
    refine hne (mem_obd.mpr ⟨mem_cube.mp ha.1, hm, ?_⟩)
    have hnot : hshift p m a ∉ cube d N := fun hc => ha.2 (mem_hopB.mpr ⟨hm, hc⟩)
    rw [mem_cube] at hnot
    push_neg at hnot
    obtain ⟨k, hk⟩ := hnot
    rw [hshift_apply] at hk
    have := hm k
    exact ⟨k, by omega⟩
  · exact hvanR a hm

/-- The incoming layer of the cube sits inside `ibd`. -/
theorem in_mem_ibd {N : ℕ} {p m : Fin d →₀ ℕ} (hm1 : ∀ k, m k ≤ 1) {b : Fin d →₀ ℕ}
    (hb : b ∈ hopB (cube d N) p m \ cube d N) : b ∈ ibd d N m := by
  classical
  rw [Finset.mem_sdiff, mem_hopB] at hb
  obtain ⟨⟨hm, hc⟩, hout⟩ := hb
  rw [mem_cube] at hc
  refine mem_ibd.mpr ⟨fun k => ?_, hm, ?_⟩
  · have h1 := hc k
    rw [hshift_apply] at h1
    have := hm k
    have := hm1 k
    omega
  · intro hall
    exact hout (mem_cube.mpr hall)

/-! ## 4. The flux bound -/

/-- **The flux bound.**  If the amplitude vanishes on `F \ G` and is bounded by `Cn` on
`G`, the flux through `F` is at most `Cn` times the `ℓ²`-mass carried by `G` and its hop
image. -/
theorem flux_bound_gen {w : ℂ} {c : (Fin d →₀ ℕ) → ℝ} {p m : Fin d →₀ ℕ}
    (F G : Finset (Fin d →₀ ℕ)) (hzero : ∀ a ∈ F, a ∉ G → c a = 0)
    {Cn : ℝ} (hCn : 0 ≤ Cn) (hC : ∀ a ∈ G, |c a| ≤ Cn) :
    |(∑ a ∈ F, rtG u w c p m a).im|
      ≤ Cn * (‖w‖ * ((∑ a ∈ G, (‖u a‖ ^ 2 + ‖u (hshift p m a)‖ ^ 2)) / 2)) := by
  classical
  have h1 : |(∑ a ∈ F, rtG u w c p m a).im| ≤ ∑ a ∈ F, ‖rtG u w c p m a‖ :=
    (Complex.abs_im_le_norm _).trans (norm_sum_le _ _)
  have h2 : ∑ a ∈ F, ‖rtG u w c p m a‖ = ∑ a ∈ F ∩ G, ‖rtG u w c p m a‖ := by
    refine (Finset.sum_subset Finset.inter_subset_left ?_).symm
    intro x hx hxn
    have : c x = 0 := hzero x hx (fun hg => hxn (Finset.mem_inter.mpr ⟨hx, hg⟩))
    rw [rtG, this]
    simp
  have h3 : ∑ a ∈ F ∩ G, ‖rtG u w c p m a‖ ≤ ∑ a ∈ G, ‖rtG u w c p m a‖ :=
    Finset.sum_le_sum_of_subset_of_nonneg Finset.inter_subset_right
      (fun _ _ _ => norm_nonneg _)
  have h4 : ∀ a ∈ G, ‖rtG u w c p m a‖
      ≤ Cn * (‖w‖ * ((‖u a‖ ^ 2 + ‖u (hshift p m a)‖ ^ 2) / 2)) := by
    intro a ha
    have hnorm : ‖rtG u w c p m a‖ = ‖w‖ * |c a| * ‖u a‖ * ‖u (hshift p m a)‖ := by
      rw [rtG]; simp [Complex.norm_real]
    have hprod : ‖u a‖ * ‖u (hshift p m a)‖
        ≤ (‖u a‖ ^ 2 + ‖u (hshift p m a)‖ ^ 2) / 2 := by
      nlinarith [sq_nonneg (‖u a‖ - ‖u (hshift p m a)‖)]
    have hb1 : ‖w‖ * |c a| ≤ ‖w‖ * Cn :=
      mul_le_mul_of_nonneg_left (hC a ha) (norm_nonneg w)
    rw [hnorm]
    calc ‖w‖ * |c a| * ‖u a‖ * ‖u (hshift p m a)‖
        = (‖w‖ * |c a|) * (‖u a‖ * ‖u (hshift p m a)‖) := by ring
      _ ≤ (‖w‖ * Cn) * (‖u a‖ * ‖u (hshift p m a)‖) := by
          refine mul_le_mul_of_nonneg_right hb1 ?_
          positivity
      _ ≤ (‖w‖ * Cn) * ((‖u a‖ ^ 2 + ‖u (hshift p m a)‖ ^ 2) / 2) := by
          refine mul_le_mul_of_nonneg_left hprod ?_
          positivity
      _ = Cn * (‖w‖ * ((‖u a‖ ^ 2 + ‖u (hshift p m a)‖ ^ 2) / 2)) := by ring
  calc |(∑ a ∈ F, rtG u w c p m a).im|
      ≤ ∑ a ∈ F ∩ G, ‖rtG u w c p m a‖ := by rw [← h2]; exact h1
    _ ≤ ∑ a ∈ G, ‖rtG u w c p m a‖ := h3
    _ ≤ ∑ a ∈ G, Cn * (‖w‖ * ((‖u a‖ ^ 2 + ‖u (hshift p m a)‖ ^ 2) / 2)) :=
        Finset.sum_le_sum h4
    _ = Cn * (‖w‖ * ((∑ a ∈ G, (‖u a‖ ^ 2 + ‖u (hshift p m a)‖ ^ 2)) / 2)) := by
        rw [← Finset.mul_sum, ← Finset.mul_sum, Finset.sum_div]

/-! ## 5. Bessel's inequality for the two boundary layers -/

theorem obd_multiplicity (p m : Fin d →₀ ℕ) (hp : ∀ k, p k ≤ 2) (a : Fin d →₀ ℕ) (M : ℕ) :
    (((Finset.range M).filter (fun N => a ∈ obd d N p m)).card) ≤ 2 := by
  classical
  set S := Finset.univ.sup (fun k : Fin d => a k) with hS
  set T := Finset.univ.sup (fun k : Fin d => a k + p k) with hT
  have hTS : T ≤ S + 2 := by
    refine Finset.sup_le fun k _ => ?_
    have h1 : a k ≤ S := Finset.le_sup (f := fun k : Fin d => a k) (Finset.mem_univ k)
    have := hp k
    omega
  have hsub : ((Finset.range M).filter (fun N => a ∈ obd d N p m)) ⊆ Finset.Ico S T := by
    intro N hN
    simp only [Finset.mem_filter] at hN
    rw [mem_obd] at hN
    obtain ⟨hle, -, k, hk⟩ := hN.2
    refine Finset.mem_Ico.mpr ⟨Finset.sup_le fun j _ => hle j, ?_⟩
    exact lt_of_lt_of_le hk
      (Finset.le_sup (f := fun k : Fin d => a k + p k) (Finset.mem_univ k))
  calc (((Finset.range M).filter (fun N => a ∈ obd d N p m)).card)
      ≤ (Finset.Ico S T).card := Finset.card_le_card hsub
    _ = T - S := Nat.card_Ico _ _
    _ ≤ 2 := by omega

theorem obd_image_multiplicity (p m : Fin d →₀ ℕ) (hp : ∀ k, p k ≤ 2) (y : Fin d →₀ ℕ)
    (M : ℕ) :
    (((Finset.range M).filter
      (fun N => y ∈ (obd d N p m).image (hshift p m))).card) ≤ 2 := by
  classical
  refine le_trans (Finset.card_le_card ?_) (obd_multiplicity p m hp (hshift m p y) M)
  intro N hN
  simp only [Finset.mem_filter, Finset.mem_image] at hN ⊢
  obtain ⟨hNr, a, ha, hay⟩ := hN
  have hao := ha
  rw [mem_obd] at hao
  have hya : hshift m p y = a := by rw [← hay, hshift_hshift hao.2.1]
  exact ⟨hNr, by rw [hya]; exact ha⟩

theorem ibd_multiplicity (m : Fin d →₀ ℕ) (b : Fin d →₀ ℕ) (M : ℕ) :
    (((Finset.range M).filter (fun N => b ∈ ibd d N m)).card) ≤ 1 := by
  classical
  set S := Finset.univ.sup (fun k : Fin d => b k) with hS
  have hsub : ((Finset.range M).filter (fun N => b ∈ ibd d N m)) ⊆ Finset.Ico (S - 1) S := by
    intro N hN
    simp only [Finset.mem_filter] at hN
    rw [mem_ibd] at hN
    obtain ⟨hle, -, hnot⟩ := hN.2
    push_neg at hnot
    obtain ⟨k, hk⟩ := hnot
    have h1 : S ≤ N + 1 := Finset.sup_le fun j _ => hle j
    have h2 : b k ≤ S := Finset.le_sup (f := fun k : Fin d => b k) (Finset.mem_univ k)
    exact Finset.mem_Ico.mpr ⟨by omega, by omega⟩
  calc (((Finset.range M).filter (fun N => b ∈ ibd d N m)).card)
      ≤ (Finset.Ico (S - 1) S).card := Finset.card_le_card hsub
    _ = S - (S - 1) := Nat.card_Ico _ _
    _ ≤ 1 := by omega



theorem obd_mass_le {B : ℝ} (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B)
    (p m : Fin d →₀ ℕ) (hp : ∀ k, p k ≤ 2) (M : ℕ) :
    ∑ N ∈ Finset.range M, ∑ a ∈ obd d N p m, ‖u a‖ ^ 2 ≤ 2 * B := by
  have := CarlemanTwoStep.sum_range_of_multiplicity (u := u) 2 hbes
    (fun N => obd d N p m) (obd_multiplicity p m hp) M
  simpa using this







/-! ## 6. The recursion and the criterion -/

/-- **A general-hop ladder recursion.**  A real diagonal `lam`, and a finite family of
Hermitian hops `α ↦ α + p h − m h` with constant amplitudes `w h`. -/
def LadderRecH (u : (Fin d →₀ ℕ) → ℂ) (lam : (Fin d →₀ ℕ) → ℝ) {ι : Type*} [Fintype ι]
    (p m : ι → (Fin d →₀ ℕ)) (c c' : ι → (Fin d →₀ ℕ) → ℝ) (w : ι → ℂ) (z : ℂ) : Prop :=
  ∀ a : Fin d →₀ ℕ,
    ((lam a : ℝ) : ℂ) * u a
      + ∑ h : ι, ((starRingEnd ℂ) (w h) * ((c h a : ℝ) : ℂ) * u (hshift (p h) (m h) a)
          + w h * ((c' h a : ℝ) : ℂ) * u (hshift (m h) (p h) a))
      = z * u a

variable {ι : Type*} [Fintype ι] {lam : (Fin d →₀ ℕ) → ℝ} {p m : ι → (Fin d →₀ ℕ)}
  {c c' : ι → (Fin d →₀ ℕ) → ℝ} {w : ι → ℂ} {z : ℂ}





end

end BookProof.CarlemanGeneralHop
