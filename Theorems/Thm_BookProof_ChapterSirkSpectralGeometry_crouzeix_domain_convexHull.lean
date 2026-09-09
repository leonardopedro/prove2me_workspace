-- Generated from ChapterSirkSpectralGeometry.lean — theorem BookProof.ChapterSirkSpectralGeometry.crouzeix_domain_convexHull
import Mathlib
import Definitions.Def_ChapterSirkSpectralGeometry
open BookProof.ChapterSirkSpectralGeometry








noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterH9
open BookProof.ChapterSirkEndToEnd BookProof.HashimotoShiftInvert BookProof.FarisLavine






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}







variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  {G : Type*} [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

theorem BookProof.ChapterSirkSpectralGeometry.crouzeix_domain_convexHull (V : G →L[ℂ] E) (X : E →L[ℂ] E)
    (hViso : ∀ x : G, ‖V x‖ = ‖x‖) (S : Set ℂ) (hconv : Convex ℝ S) (hS : numRange X ⊆ S) :
    convexHull ℝ (numRange (compress V X)) ⊆ S := by sorry
