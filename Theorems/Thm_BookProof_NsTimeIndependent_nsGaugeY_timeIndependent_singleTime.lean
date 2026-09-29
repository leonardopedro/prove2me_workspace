-- Generated from ChapterNsTimeIndependentFlow.lean — theorem BookProof.NsTimeIndependent.nsGaugeY_timeIndependent_singleTime
import Mathlib
import Definitions.Def_ChapterNsTimeIndependentFlow
open BookProof.NsTimeIndependent











open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.FiniteSectionSingleTime
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.NSHashimoto
open BookProof.NavierStokesFlow.LagrangianEsa BookProof.NavierStokesFlow.LagrangianCanonical
open BookProof.NavierStokesFlow.LagrangianKatoRellich

noncomputable section

open BookProof.NavierStokesGaugeY in
theorem BookProof.NsTimeIndependent.nsGaugeY_timeIndependent_singleTime (nu : ℂ) (A : Matrix (Fin 3) (Fin 3) ℝ)
    (c : Fin 3 → ℝ) (en : ℕ ≃ Vel) :
    (∀ i j : Fin 3, genY j (nsSymbol nu i) = 0) ∧
      (∀ i : Fin 3, setYZero (nsSymbol nu i) = nsSymbolPoint nu i) ∧
      ∃ (T : UnboundedSelfAdjoint (L2I Vel)) (S : ℕ → UnboundedSelfAdjoint (L2I Vel)),
        IsSelfAdjointExtension (velCore A c) T.op ∧
          (∀ n, IsSelfAdjointExtension
            (((secOp (velCore A c) (windowOfEquiv en n) : L2I Vel →ₗ[ℂ] L2I Vel)).comp
              (lpFiniteModes Vel).subtype) (S n).op) ∧
          (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
          (∀ (t s : ℝ) (x : L2I Vel), ‖prop T t s x‖ = ‖x‖) ∧
          (∀ (t s r : ℝ) (x : L2I Vel), prop T t s (prop T s r x) = prop T t r x) ∧
          (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
          (∀ y : ℝ → L2I Vel, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
          (∀ l : ℝ, l ≠ 0 →
            IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
              (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
              ∀ u : L2I Vel,
                Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
          ∀ (v : L2I Vel) (t : ℝ),
            Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by sorry
