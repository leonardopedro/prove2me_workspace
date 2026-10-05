-- Generated from ChapterDegKatoEsa.lean — theorem BookProof.DegKatoEsa.mollified_identity
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterMollifierL2
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.HermiteProductCore
open BookProof.ScalaronEsa
open BookProof.DegKatoEsa

variable {d : ℕ}



open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc BookProof.DegEnergy BookProof.MollifierL2

noncomputable section


theorem BookProof.DegKatoEsa.mollified_identity (W : Vd d → ℝ) (hWs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W)
    (S : Finset (Fin d)) {z : ℂ} {u : L2d d}
    (hu : ∀ v : ccDomain (Vd d), (inner ℂ (ccHamS W hWs S v) u : ℂ)
      = z * inner ℂ ((v : L2d d)) u)
    {ρ : Vd d → ℝ} (hρ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) ρ) (hρc : HasCompactSupport ρ)
    (x : Vd d) :
    lapCS S (cnv ((u : Vd d → ℂ)) (cx ρ)) x
      = cnv (fun y => ((W y : ℝ) : ℂ) * (u : Vd d → ℂ) y) (cx ρ) x
        - z * cnv ((u : Vd d → ℂ)) (cx ρ) x := by sorry
